% 2022-05-26 / Katarina Dejanovic / Changed the sending of MVC value, just
% the part of the signal (where contraction is detected) is averaged and
% sent
function propTable = CreatePRtable_ALCD(tW, iW, recSession, patRec)

    %% Load data from recSession
    nR = recSession.nR;
    cT = recSession.cT;
    rT = recSession.rT;
    sT = recSession.sT;
%     nCh = recSession.nCh;
    nCh = length(patRec.nCh); % here use patRec in case not all channels are used
    sF = recSession.sF;
%     nM = recSession.nM;
    nM = patRec.nM - 1; % here use patRec in case not all movements are used
    tWs = tW*sF;
    iWs = iW*sF;
    oWs = tWs-iWs;
    nW = ((length(recSession.tdata)-tWs)/iWs)+1;
    t = [0:1/sF:sT-1/sF];
    t1 = t(tWs:iWs:end);

    %% check how to proceed for the table
    if isfield(recSession,'ramp')
        choice = questdlg('A ramp recording session was selected. How would you prefer to proceed to calculate the proportionality?', 'Ramp RecSession found!', ...
            'calculate from the recording','use the Maximum Voluntary Contraction sessions','use the Maximum Voluntary Contraction sessions');
        switch choice
            case 'calculate from the recording'
                calculate = 1;
            case 'use the Maximum Voluntary Contraction sessions'
                calculate = 0;
        end
    else
        calculate = 1;
    end
    if calculate
        %% we calculate the maximum values over the data provided
        % Windowing the data
        for m = 1:nM
            for i = 1:nW
                iidx = 1 + (iWs * (i-1));
                eidx = tWs + (iWs *(i-1));
                windowedData(:,:,m,i) = recSession.tdata(iidx:eidx,:,m);
            end
        end
        % Features extraction
        for m = 1:nM
            for i = 1:nW
                features(i,m) = GetSigFeatures(windowedData(:,:,m,i),sF,0);    
            end
            tmabs(:,:,m) = reshape([features(:,m).tmabs],nCh,nW)';
            % tstd, tvar, twl, trms, tzc, tslpch2, tpwr, tdam, tmfl, 
            % tfdh, tfd, tcard, tren, fwl, fmn, fmd
        end
        % Average the repetitions for movements
        for m = 1:nM
            for i=1:nR
                temp_idx = find((t1>=(i-1)*(cT+rT))&(t1<=(cT*i+rT*(i-1)))==1);
                if i==1
                    indexes(i,:) = [1 1 1 temp_idx]; 
                else
                    indexes(i,:) = temp_idx;
                end 
                temp_tmabs(:,:,m,i) = tmabs(indexes(i,:),:,m); 
            end    
        end
        avg_tmabs = mean(temp_tmabs,4);
        % Build Table with movements
        for m = 1:nM
            propTable(:,m) = max(avg_tmabs(:,:,m))';
        end
        % Average for rest state (using rest after first repetition)
        for m = 1:nM
            temp_idx = find((t1>=(cT+rT/3))&(t1<=(cT+rT-rT/3))==1);
            rest_tmabs(:,:,m) = mean(tmabs(temp_idx,:,m));
        end
        propTable(:,nM+1) = mean(rest_tmabs,3);
    else
        %% we use the Maximum Voluntary Contraction sessions included in the ramp recording
%         for m = 1:nM
%             features = GetSigFeatures(recSession.ramp.maxData(:,:,m),sF,0);
%             propTable(:,m) = features.tmabs;
%         end
%         propTable(:,nM+1) = mean(recSession.ramp.minData);
        maxData = recSession.ramp.maxData;
        minData = recSession.ramp.minData;
        if ~isempty(setdiff(recSession.vCh,patRec.vCh))
            maxData = maxData(:,ismember(recSession.vCh,patRec.vCh),:);
            minData = minData(:,ismember(recSession.vCh,patRec.vCh));
        end
        if ~isempty(setdiff(recSession.mov,patRec.mov(1:end-1)))
            maxData = maxData(:,:,ismember(recSession.mov,patRec.mov(1:end-1)));
        end
        a = 1;
        b = 1/50.*ones(50,1)';
        maxRampMAV = abs(maxData);
        maxRampMAV = filter(b,a,maxRampMAV);
        maxRampMAV = downsample(maxRampMAV,25);
        % detect when the contraction started, and take the mean from that
        % point
        for m = 1:nM
            dMaxMav = high_pass(maxRampMAV(:,:,m));
            [~,dInd] = max(dMaxMav);
            for ch = 1:nCh
                if (dInd(ch) > 20)
                    dInd(ch) = 20;
                end
                propTable(ch,m) = mean(maxRampMAV(dInd(ch):end-10,ch,m),1);
            end
        end
        propTable(:,nM+1) = mean(minData);
    end
    
end