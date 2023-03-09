% Function to be used only on the matrix which contains the information on
% which channels to use for proportional control
% ** input variable: pC -> matrix which is nM x nCh (where nM is the number of
% movements and nCh is the total number of channels), each cell of the
% matrix is 1 or 0, 1 indicating that the channel (which is the collumn number
% of the cell) is used for the movement (which is row number of the cell)
% in proportional control
% ** output variable: pCompressed -> is supposed to contain the same
% information as the pC variable but written differently. pCompressed
% contains nM values, where each value in binary indicates which channels
% is used for that movement. 
% Eg. 11001 -> channels 1, 4 and 5 are used for proportional control (you
% read it from right to left)
function pCompressed = CompressPropChannels(pC)
nM = size(pC,1);
nCh = size(pC,2);
pCompressed = zeros(nM,1);
for m = 1:nM
    temp = 0;
    for c = 1:nCh
        temp = temp + pC(m,c)*2^(c-1); % convert the row in the pC matrix into corresponding binary value
    end
    pCompressed(m) = temp;
end
end