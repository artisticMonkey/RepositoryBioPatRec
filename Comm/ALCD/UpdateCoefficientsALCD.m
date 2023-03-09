% UPDATE COEFFICIENTS 
% 2022-05-26 / Katarina Dejanovic / Changed the SVM function for transient EMG to fitcsvm in training, therefore
% the parameters which are sent are different.
function UpdateCoefficientsALCD(handles)

global derivativeOnset;
global waitSamples;

if isempty(derivativeOnset)
    derivativeOnset = 0; waitSamples = 0;
    disp("The variables derivativeOnset and waitSamples were deleted");
end

ComMode     = handles.patRec.comm;

set(handles.t_msg,'String','Testing connection...');
if strcmp(ComMode, 'WiFi')
    obj = tcpip('192.168.100.10',65100,'NetworkRole','client');        % WIICOM
else
    if isfield(handles.patRec, 'comn')
        ComPortName = handles.patRec.comn;
    else
        ComPortName = 'INVALID';
    end
%     ComPortName = 'COM8';
    % Change to always choose the COM port
    % Get COM Port from user if saved one is not present
    hwInfo = instrhwinfo('serial');
    comPorts = hwInfo.AvailableSerialPorts;
%     portExists = cellfun(@(s) ~isempty(strfind(ComPortName,s)), comPorts);
%     if ~any(portExists) && ~isempty(comPorts)
        [comIdx,valid] = listdlg('PromptString','Select a COM Port:', ...
            'ListSize',[160 100], ...
            'SelectionMode','single', ...
            'ListString',comPorts);
        if ~valid
            set(handles.t_msg,'String','Invalid COM Port selection');
            return;
        end
        ComPortName = comPorts{comIdx};
%     elseif ~any(portExists)
%         set(handles.t_msg,'String','No connection available');
%         return;
%     end
    
    obj = serial (ComPortName, 'baudrate', 460800, 'databits', 8, 'byteorder', 'bigEndian');
end

% Open and test connection
fclose(obj);
% Set warnings to temporarily issue error (exceptions)
s = warning('error', 'instrument:fread:unsuccessfulRead');
try
    fopen(obj);
    fwrite(obj,'A','char');
    fwrite(obj,'C','char');
    replay = char(fread(obj,1,'char'));
catch exception
    set(handles.t_msg,'String','Error, device is not responding or COM port is changed!');
    delete(obj);
    return
end
%Set warning back to normal state
warning(s);
if strcmp(replay,'C')
    set(handles.t_msg,'String','Connection Established');
else
    set(handles.t_msg,'String','Error, device is not responding or COM port is changed!');
end
fclose(obj);
handles.obj = obj;

% Open the connection
fopen(obj);

% Read available data and discard it
if obj.BytesAvailable > 0
    fread(obj,obj.BytesAvailable,'uint8');    % Read the samples
end

if strcmp(handles.patRec.patRecTrained.algorithm,'REG')
    % set features and time windows size
    tWs = handles.patRec.sF*handles.patRec.patRecTrained.tW;
    oWs = 0;
    FeaturesEnables = zeros(1,5);
    if sum(strcmp(handles.patRec.selFeatures,'tmabs')==1)
        FeaturesEnables(1) = 1; end
    if sum(strcmp(handles.patRec.selFeatures,'twl')==0)
        FeaturesEnables(2) = 1; end
    if sum(strcmp(handles.patRec.selFeatures,'tzc')==0)
        FeaturesEnables(3) = 1; end
    if sum(strcmp(handles.patRec.selFeatures,'tslpch2')==0)
        FeaturesEnables(4) = 1; end
    if sum(strcmp(handles.patRec.selFeatures,'tstd')==0)
        FeaturesEnables(5) = 1; end
    SetFeaturesExtractionParametersALCD(handles, tWs, oWs, FeaturesEnables);
    % Send coeffs float values to ALC
    coeffs = handles.patRec.patRecTrained.coeffs;
    nMovs = size(coeffs,2);
    nCh = size(coeffs,1);
    fwrite(obj,'U','char');
    fwrite(obj,nMovs,'char');
    fwrite(obj,nCh,'char');
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'U')
        set(handles.t_msg,'String','Upload Start');
    else
        set(handles.t_msg,'String','Error Start');
        fclose(obj);
        return
    end
    tic;
    for i = 1:nMovs
        for k = 1:nCh
            fwrite(obj,coeffs(i,k),'float');
        end
    end
    toc;
    replay = char(fread(obj,1,'char'));
    if strcmp(replay,'U');
        set(handles.t_msg,'String','Upload completed');
    else
        set(handles.t_msg,'String','Error uploading');
        fclose(obj);
        return
    end
    
else
    
% Set the parameters for features extraction
%tWs = handles.patRec.sF*handles.patRec.tW;
%oWs = handles.patRec.sF*handles.patRec.tW - handles.patRec.sF*handles.patRec.wOverlap;
tWs = handles.patRec.sF*handles.patRec.tW;    % default values are written in the MCU
oWs = handles.patRec.sF*(handles.patRec.tW - handles.patRec.wOverlap);
FeaturesEnables = zeros(1,5);
if (sum(strcmp(handles.patRec.selFeatures,'tmabs')==1) || sum(strcmp(handles.patRec.selFeatures,'tmabsTr1')==1)) % AM 201901
    FeaturesEnables(1) = 1; end
if (sum(strcmp(handles.patRec.selFeatures,'twl')==1) )
    FeaturesEnables(2) = 1; end
if (sum(strcmp(handles.patRec.selFeatures,'tzc')==1)  || sum(strcmp(handles.patRec.selFeatures,'tmabsTr2')==1))
    FeaturesEnables(3) = 1; end
if (sum(strcmp(handles.patRec.selFeatures,'tslpch2')==1) )
    FeaturesEnables(4) = 1; end
if (sum(strcmp(handles.patRec.selFeatures,'tstd')==1)   || sum(strcmp(handles.patRec.selFeatures,'tmabsTr3')==1)  )
    FeaturesEnables(5) = 1; end
SetFeaturesExtractionParametersALCD(handles, tWs, oWs, FeaturesEnables);
% Load coefficients depending on the training algorithm used
    switch handles.patRec.patRecTrained.algorithm
        case 'DA'
            coeff = handles.patRec.patRecTrained.coeff;
            dimCOEFF = size(coeff,2);
            dimLINEAR = size(coeff(1,2).linear,1);
            % Start to send coeff float values
            fwrite(obj,'U','char');
            fwrite(obj,dimCOEFF,'char');
            fwrite(obj,dimLINEAR,'char');
            fwrite(obj,handles.patRec.floorNoise,'float');
            replay = char(fread(obj,1,'char'));
            if strcmp(replay,'U')
                set(handles.t_msg,'String','Upload Start');
            else
                set(handles.t_msg,'String','Error Start');
                fclose(obj);
                return
            end
            % Optimization: normal vectors are pre-calculated on the PC side
            for i = 1:dimCOEFF
                L = zeros(dimLINEAR,1);
                K = 0;
                for j = 1 : dimCOEFF
                    if i ~= j
                        L = L + coeff(i,j).linear;
                        K = K + coeff(i,j).const;
                    end
                end
                w(i).L = L;
                k(i).K = K;
            end
            % send normal vectors to the ALC-D
            tic;
            for i = 1:dimCOEFF
                fwrite(obj,k(i).K,'float');
                for z = 1:dimLINEAR
                    fwrite(obj,w(i).L(z),'float');
                end
            end
            toc;
            replay = char(fread(obj,1,'char'));
            if strcmp(replay,'U');
                set(handles.t_msg,'String','Upload completed');
            else
                set(handles.t_msg,'String','Error uploading');
                fclose(obj);
                return
            end
            
        case 'SVM'
            % Optimization: normal vectors are pre-calculated on the PC side
            classes = size(handles.patRec.patRecTrained.SVM,2);
            for iClasses = 1:classes
%                 svm_struct = handles.patRec.patRecTrained.SVM(:,iClasses);
%                 sv = svm_struct.SupportVectors;
%                 alphaHat = svm_struct.Alpha;
%                 w(iClasses,:) = alphaHat'*sv;
                svm_struct = handles.patRec.patRecTrained.SVM{iClasses};
                w(iClasses,:) = svm_struct.Beta'; % KD: 20220519
            end
            midrange = handles.patRec.normSets.midrange;
            range = handles.patRec.normSets.range;
%             shift = svm_struct.ScaleData.shift;
%             scale = svm_struct.ScaleData.scaleFactor;
            shift = svm_struct.Mu;
            scale = svm_struct.Sigma;
            nMovements = classes;
            dimLINEAR = size(w,2);
            if (isempty(svm_struct.Mu)) % KD: 20220519, in case the scaling was off, put shift to 0 and scale to 1
                shift = zeros(1,dimLINEAR);
                scale = ones(1,dimLINEAR);
            end
            % Start communication
            fwrite(obj,'u','char');
            fwrite(obj,nMovements,'char');
            fwrite(obj,dimLINEAR,'char');
            % Send first normalization parameters
            for k = 1:dimLINEAR
                fwrite(obj,midrange(k),'float');
                fwrite(obj,range(k),'float');
                fwrite(obj,shift(k),'float');
                fwrite(obj,scale(k),'float');
            end
            % Start to send coeff float values
            fwrite(obj,handles.patRec.floorNoise,'float');
            replay = char(fread(obj,1,'char'));
            if strcmp(replay,'u')
                set(handles.t_msg,'String','Upload Start');
            else
                set(handles.t_msg,'String','Error Start');
                fclose(obj);
                return
            end
            tic;
            for i = 1:nMovements
                fwrite(obj,handles.patRec.patRecTrained.SVM{i}.Bias,'float');
                for k = 1:dimLINEAR
                    fwrite(obj,w(i,k),'float');
                end
            end
            toc;
            replay = char(fread(obj,1,'char'));
            if strcmp(replay,'u');
                set(handles.t_msg,'String','Upload completed');
            else
                set(handles.t_msg,'String','Error uploading');
                fclose(obj);
                return
            end
            
        case 'SVMt'
            % Optimization: normal vectors are pre-calculated on the PC side            
            classes = size(handles.patRec.patRecTrained.SVM,2);
            kernel  = uint8(strcmp(handles.patRec.patRecTrained.SVM{1}.KernelParameters.Function,'polynomial'));
            for iClasses = 1:classes
%                 svm_struct = handles.patRec.patRecTrained.SVM(:,iClasses);
%                 sv = svm_struct.SupportVectors;
%                 alphaHat = svm_struct.Alpha;
%                 w(iClasses,:) = alphaHat'*sv;
                svm_struct = handles.patRec.patRecTrained.SVM{iClasses};
                if (kernel)
                    w{iClasses}.w = (svm_struct.Alpha.*svm_struct.SupportVectorLabels)';
                    w{iClasses}.supVec = svm_struct.SupportVectors;
%                     w{iClasses}.supVec = round((w{iClasses}.supVec+1).*(256/2));
                    w{iClasses}.supVec = round((w{iClasses}.supVec+1).*(255/2) - 128);
                    nSupVec(iClasses) = size(svm_struct.SupportVectors,1);
                else
                    w(iClasses,:) = svm_struct.Beta'; % KD: 20220519
                end
            end
            midrange = handles.patRec.normSets.midrange;
            range = handles.patRec.normSets.range;
            shift = svm_struct.Mu;
            scale = svm_struct.Sigma;
            nMovements = classes;
            dimLINEAR = length(midrange);
            % if the scaling was not done by the SVM then just put shift as
            % 0 and scale as 1
            if (isempty(svm_struct.Mu)) % KD: 20220519, in case the scaling was off, put shift to 0 and scale to 1
                shift = zeros(1,dimLINEAR);
                scale = ones(1,dimLINEAR);
            end
%             shift = svm_struct.ScaleData.shift;
%             scale = svm_struct.ScaleData.scaleFactor;
            
            % Start communication
            fwrite(obj,'t','char');
            fwrite(obj,nMovements,'char');
            fwrite(obj,dimLINEAR,'char');

%             replay1 = (fread(obj,1,'char'));
%             replay2 = (fread(obj,1,'char'));

            
            % Send first normalization parameters
            for k = 1:dimLINEAR
                fwrite(obj,midrange(k),'float');
                fwrite(obj,range(k),'float');
                fwrite(obj,shift(k),'float');
                fwrite(obj,scale(k),'float');
%                 iii = (fread(obj,1,'char'))
            end
            
            % Start to send coeff float values
            %fwrite(obj,handles.patRec.floorNoise,'float');
            
            %
            %ADD HERE CODE FOR THRESHOLD (TR_EMGthreshold) - can we use floorNoise?
            % Yes we could but for now I used a different algorithm to
            % aproximate the threshold
            fwrite(obj,waitSamples,'char');
            fwrite(obj,derivativeOnset,'char');
            fwrite(obj,handles.patRec.threshold,'float');
            disp(num2str(handles.patRec.threshold));
            %ADD HERE CODE FOR MAX EMG (used to normalize the position
            %control between 1 and 255)
            for i = 1:numel(handles.patRec.maxVals)
                fwrite(obj,handles.patRec.maxVals(i),'float');
%                 kkk = (fread(obj,1,'char'))
            end
            
            replay = char(fread(obj,1,'char'));
            if strcmp(replay,'t')
                set(handles.t_msg,'String','Upload Start');
            else
                set(handles.t_msg,'String','Error Start');
                fclose(obj);
                return
            end
%             fwrite(obj,kernel,'uint8');
            tic;
            for i = 1:nMovements
                fwrite(obj,handles.patRec.patRecTrained.SVM{i}.Bias,'float32');
                if (kernel)
                    fwrite(obj,nSupVec(i),'uint8');
                    for k = 1:nSupVec(i)
                        fwrite(obj,w{i}.w(k),'float32');
                        for j = 1:dimLINEAR
                            fwrite(obj,w{i}.supVec(k,j),'int8');
                        end
                    end
                else
                    for k = 1:dimLINEAR
                        fwrite(obj,w(i,k),'float');
                    end
                end
            end
            toc;
            replay = char(fread(obj,1,'char'));
            if strcmp(replay,'t');
                set(handles.t_msg,'String','Upload completed');
            else
                set(handles.t_msg,'String','Error uploading');
                fclose(obj);
                return
            end
            
        case 'SVMtHW' %180821FC
            %%% movements list management
            % take movements from the BioPatRec list
            movList = handles.patRec.mov(1:end-1); % REST is excluded
            %movList = handles.patRec.mov; % there is no REST in the list
            AllmovW = {'Flex Hand' 'Extend Hand' 'Pronation' 'Supination'};
            counter = 0;
            for i = 1:length(movList)
                for j = 1:length(AllmovW)
                    if strcmp(movList{i},AllmovW{j})
                        counter = counter + 1;
                        movGlobalIdxW(counter) = i;
                    end
                end
            end
            % i movimenti mano saranno i restanti -> implementare
            movGlobalIdxH = 1:length(movList);
            movGlobalIdxH(movGlobalIdxW) = [];
            
            % Optimization: normal vectors are pre-calculated on the PC side
            classesH = size(handles.patRec.patRecTrained.SVM.H,2);
            classesW = size(handles.patRec.patRecTrained.SVM.W,2);
            for iClasses = 1:classesH
                svm_struct = handles.patRec.patRecTrained.SVM.H(:,iClasses);
                sv = svm_struct.SupportVectors;
                alphaHat = svm_struct.Alpha;
                wH(iClasses,:) = alphaHat'*sv;
            end
            midrange = handles.patRec.normSets.midrange;
            range = handles.patRec.normSets.range;
            %             if ((handles.patRec.patRecTrained.SVM.H(1).ScaleData.shift - handles.patRec.patRecTrained.SVM.W(1).ScaleData.shift==0) && ...
            %                 (handles.patRec.patRecTrained.SVM.H(1).ScaleData.scaleFactor - handles.patRec.patRecTrained.SVM.W(1).ScaleData.scaleFactor==0))
            %             else
            %                 warning('HAND and WRIST shift and/or scale factors do not match. Using HAND ones.')
            %             end
            shift = svm_struct.ScaleData.shift; % should be the same for both classifiers
            scale = svm_struct.ScaleData.scaleFactor; % should be the same for both classifiers
            
            for iClasses = 1:classesW
                svm_struct = handles.patRec.patRecTrained.SVM.W(:,iClasses);
                sv = svm_struct.SupportVectors;
                alphaHat = svm_struct.Alpha;
                wW(iClasses,:) = alphaHat'*sv;
            end
            nMovementsH = classesH;
            nMovementsW = classesW;
            dimLINEAR = size(wH,2); % should be the same for both classifiers
            
            % Start communication
            fwrite(obj,'z','char');
            fwrite(obj,nMovementsH,'char');
            fwrite(obj,nMovementsW,'char');
            fwrite(obj,dimLINEAR,'char');
            
%             replay1 = (fread(obj,1,'char'))
%             replay2 = (fread(obj,1,'char'))
%             replay3 = (fread(obj,1,'char'))
            
            for i=1:nMovementsH-1
                fwrite(obj,movGlobalIdxH(i),'char');
%                 iii = (fread(obj,1,'char'))
            end
            fwrite(obj,99,'char');
%             iii = (fread(obj,1,'char'))
            for i=1:nMovementsW-1
                fwrite(obj,movGlobalIdxW(i),'char');
%                 kkk = (fread(obj,1,'char'))
            end
            
            %replayArr = char(fread(obj,1,'char'));
            replayArr = char(fread(obj,5,'char')); %5 bytes for debug. normally it is 1
            if strcmp(replayArr(1),'z')
                set(handles.t_msg,'String','OK1');
                disp(replayArr)
                drawnow
            else
                set(handles.t_msg,'String','ERR1');
                drawnow
                fclose(obj);
                return
            end
            
            % Send first normalization parameters
            for k = 1:dimLINEAR
                fwrite(obj,midrange(k),'float');
                fwrite(obj,range(k),'float');
                fwrite(obj,shift(k),'float');
                fwrite(obj,scale(k),'float');
%                 jjj = (fread(obj,1,'char'))
            end
            
            replay = char(fread(obj,1,'char'));
            if strcmp(replay,'z')
                set(handles.t_msg,'String','OK2');
                drawnow
            else
                set(handles.t_msg,'String','ERR2');
                drawnow
                fclose(obj);
                return
            end
            
            %noise threshold
            fwrite(obj,handles.patRec.threshold,'float');
            disp(num2str(handles.patRec.threshold));
%             replay = [];
            replay = char(fread(obj,1,'char'));
            if strcmp(replay,'z')
                set(handles.t_msg,'String','OK3');
                drawnow
            else
                set(handles.t_msg,'String','ERR3');
                drawnow
                fclose(obj);
                return
            end
            
            %MAX EMG (used to normalize the position control between 1 and 255)
            for i = 1:numel(handles.patRec.maxVals)
                fwrite(obj,handles.patRec.maxVals(i),'float');
%                 aa = (fread(obj,1,'float'))
%                 ii = (fread(obj,1,'char'))
            end
            
            replay = char(fread(obj,1,'char'));
            if strcmp(replay,'z')
                set(handles.t_msg,'String','Upload Start');
                drawnow
            else
                set(handles.t_msg,'String','Error Start');
                drawnow
                fclose(obj);
                return
            end
            tic;
            for i = 1:nMovementsH
                fwrite(obj,handles.patRec.patRecTrained.SVM.H(:,i).Bias,'float');
                for k = 1:dimLINEAR
                    fwrite(obj,wH(i,k),'float');
%                     cazzo = (fread(obj,1,'char'))
                end
            end
            for i = 1:nMovementsW
                fwrite(obj,handles.patRec.patRecTrained.SVM.W(:,i).Bias,'float');
                for k = 1:dimLINEAR
                    fwrite(obj,wW(i,k),'float');
%                     cazzo2 = (fread(obj,1,'char'))
                end
            end
            toc;
            replay = char(fread(obj,1,'char'));
            if strcmp(replay,'z');
                set(handles.t_msg,'String','Upload completed');
            else
                set(handles.t_msg,'String','Error uploading');
                fclose(obj);
                return
            end
            
    end
end

% Close connection
fclose(obj);

end
