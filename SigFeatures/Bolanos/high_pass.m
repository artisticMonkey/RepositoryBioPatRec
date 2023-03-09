function [mav_filt] = high_pass(mav)
    if size(mav,1) == 1
        mav = mav';
    end
    N   = size(mav,1);
    nCh = size(mav,2);
    mav_filt = [];
    dt = 0.2; % DD 20191011 - 0.2-->0.15
    Fs = 20; %Hz
    for i = dt*Fs+1:N
        mav_filt(i,1:nCh) = (mav(i,1:nCh)-mav(i-dt*Fs,1:nCh))/dt;
    end
end