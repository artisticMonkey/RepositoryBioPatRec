cnt = [];
idx = [];
gP = [];
out = [];
time = [];
force = [];
sdValues = SDcardValues';
s = size(sdValues,1)*size(sdValues,2);
for i = 1:(s - 2)
    if(sdValues(i) == 161 && sdValues(i+1) == 178 && sdValues(i+2) == 127)
        temp1 = dec2hex(sdValues(i+34));
        temp2 = dec2hex(sdValues(i+35));
        temp3 = dec2hex(sdValues(i+36));
        temp4 = sdValues(i+8);
        temp6 = sdValues(i+22:i+27);
%         temp6 = sdValues(i+22:i+33);
        temp5 = [];
        for j = 1:7
            tt = dec2hex(sdValues(i+36+j));
            if (strlength(tt)==1)
                tt = strcat('0',tt);
            end
            temp5 = [temp5, ' ', tt];
        end
        if (strlength(temp1)==1)
            temp1 = strcat('0',temp1);
        end
%         temp7 = [];
%         for j = 1:6
%             t1 = dec2hex(temp6(2*(j-1)+1));
%             t2 = dec2hex(temp6(2*(j-1)+2));
%             if (strlength(t1)==1)
%                 t1 = strcat('0',t1);
%             end
%             temp7 = [temp7, typecast(uint16(hex2dec(strcat(t2,t1))),'int16')];
%         end
        cnt = [cnt; hex2dec(strcat(temp2,temp1))];
        gP = [gP; hex2dec(temp3)];
        out = [out; temp4];
        idx = [idx;i];
        time = [time; temp5];
        force = [force; temp6];
    end
end

%%
motP = [];
sdValues = SDcardValues';
s = size(sdValues,1)*size(sdValues,2);
for i = 1:(s-2)
    if(sdValues(i) == 161 && sdValues(i+1) == 178 && sdValues(i+2) == 127)
        tempMot = [];
        for j = 1:3
            k = (j-1)*2;
            temp1 = dec2hex(sdValues(i+34+k));
            temp2 = dec2hex(sdValues(i+35+k));
            tempMot = [tempMot, hex2dec(strcat(temp2,temp1))];
        end
        motP = [motP; tempMot];
    end
end