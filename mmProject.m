prompt = 'Start time: ';
start_time = input(prompt);
prompt2 = 'number of packets: ';
packets_number = input(prompt2);
prompt4 = 'Enter network delays in brackets, in the form [x,x,x,x,x,x] with the same packets size:'; 
ND = input(prompt4);
prompt5 = 'Playback delay value:'; 
PD = input(prompt5);
prompt3 = 'buffer size:';
buffer_size = input(prompt3);
ED = 0;
ND1 = [ND(1)+start_time-1,ND,packets_number+start_time];
x = [start_time-1,start_time:(packets_number+start_time)];
y = [0,1:packets_number,packets_number];
ma = max(ND);
mi = min(ND);
q = ma-mi;
shift = ma-mi+start_time+ND(1)-1;
x2 = [start_time-1+shift,start_time+shift:(packets_number+start_time+shift)];
if(PD>=q)
    x3 = [x2(1)+PD-2,x2(1)+PD-1:packets_number+PD+x2(1)-1];
else
    disp("Error in playout will occur as it needs to be more than ")
    disp(q)
end
x4 = x + ND1;
for i=1:packets_number
    ED = (1-0.1)*ED+0.1*ND(i);
end
disp("Estimated Playout Delay")
disp(ED)
fmt3 = ['PlayOut:' repmat(' %1.0f\n',1,numel(q))];
fprintf(fmt3,q)
buffer = zeros(packets_number+q+1,1);
outs = zeros(packets_number+q+1,1);
ins = zeros(packets_number+q+1,1);
disp(packets_number+q+1);
for j=2:q+1
    buffer(j)=y(j);
    ins(j)=1;
end
%ins1=x4
%h=1;
for k=q+2:length(buffer)-q
    outs(k)=1;
    
    %buffer(k)=y(k)-y(q+h);
   % h=h+1;
end
%fmt=['Out:' repmat(' %1.0f\n',1,numel(outs))];
%fprintf(fmt,outs)
%fmt5 = ['In:' repmat(' %1.0f\n',1,numel(ins))];
%fprintf(fmt5,ins)
fmt2 = ['Buffer:' repmat(' %1.0f\n',1,numel(buffer))];
fprintf(fmt2,buffer)

figure
hold on
grid on;
stairs(x,y,'LineWidth',2,'Marker','p','MarkerFaceColor','r','MarkerSize',12);
stairs(x4,y,'LineWidth',1,'Marker','*','MarkerFaceColor','c','MarkerSize',12);
stairs(x2,y,'LineWidth',1,'Marker','x','MarkerFaceColor','c','MarkerSize',12);
stairs(x3,y,'LineWidth',1,'Marker','d','MarkerFaceColor','c','MarkerSize',12);
legend("Packets Generated","Packets Recieved","the PerfectPlayOut Delay","PlayOut Delays");
title("Project MM");
xlabel("Time");
ylabel("Packets");
hold off