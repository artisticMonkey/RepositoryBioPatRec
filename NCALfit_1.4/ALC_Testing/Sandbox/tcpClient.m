% notConnected = 1;
% while notConnected
%     try
%         client=tcpclient("localhost",30000);
%         notConnected = 0;
%     catch
%         disp('Not connected yet')
%     end
% end
client=tcpclient("localhost",30000,"Timeout",60*5);
data=read(client,6, "char"); % doesnt read data just waits for connection
disp(data)
data=read(client,6, "char");
disp(data)
% server=tcpserver("0.0.0.0",30000);
% 
% write(server,0,"double");