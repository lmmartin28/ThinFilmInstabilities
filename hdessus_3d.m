%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                                             %
% Numerical resolution of evolution equation for thickness of a film below a inclined plane   %
%                                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Gioele Balestra
% version 17.12.2014

%%
clear all; close all; clc;


%adim time (stillwagon and larson) : tau= \eta w^4 / gamma h_0^3
%x adim with w
%h adim with h_0

%adim eq. dh/dt=1/3 (3h^2 D1h D3h +3h^2 D1h D3s + h^3 D4h + h^3 D4s)

LIN = false; % linear solver or not

tmax=500;



N = 10; % number of grid points, modified from 512 to 10


L = 2*pi; 
amp=0.5;
amps=1;

%sigma=L/8;

dTheta = L/N;
thetaX = (0:dTheta:(L-dTheta))'; % spatial coordinate, should be distinguished between X and Y
thetaY = (0:dTheta:(L-dTheta))'; % spatial coordinate, should be distinguished between X and Y
%tspan = linspace(0,tmax,201);

tspan = linspace(0,tmax,201);

%% Initial condition

%h0=1-amp*(exp(-(cos(theta)-L/2).^2/2/sigma/sigma));
%h0=amp*(2+cos(theta));%+amp*sin(2*theta);
h0=amp*(2+(cos(thetaX).*cos(thetaY)'))./(2+(cos(thetaX).*cos(thetaY)'));
s=amps*(cos(thetaX)).*(cos(thetaY)');
%size(h0)
%size(s)
if(LIN)
    h0 = h0-1; % to look the linear evolution of the disturbances only
end

% figure(1)
% plot(theta,h0)
% xlabel('\theta') ;
% ylabel('h') ;
% title('Initial condition');
% axis([theta(1) theta(end) min(min(h0))-0.05 max(max(h0))+0.05]);
% drawnow

%pause(1);
%return


%% Differencial operators

%% Time integration

options=odeset('RelTol',1e-2,'AbsTol',1e-1,'Stats','off');%'RelTol',1e-8,'AbsTol',1e-6,'Stats','off'
cpuTime = cputime();

%how about cutting the problem into bits using a lot that sweeps the
%columns of h and s. For that we just add a parameter in hevolplandessus
%Split the problem by line, and then assemble the output matrix

%hevolplandessus is now a nxn matrix, that has to be integrated column by
%column. You have to create a loop for that, ode15s doesnt handle
%integration of matrices
%for k=1:size(hevolplandessus3d_s(t,h,s,L),2)
%   h1=();
   
%you have to break down the solver along every single column. Take as input
%the full matrix (so that he can plot the full cross derivative terms) and
%Provide him as well with the index of the colum to solve with

% as output


if(~LIN)
    
        [t,h] = ode15s(@(t,h) hevolplandessus3d_s(t,h,s,L),tspan,h0,options);
        %solver for stiff dirential equations - variable order method
        %[t,y]=ode15s(odefun,tspan,yo), where tspan= (to tf) integrates
        %the system of differential equations y'=f(y,t) from to to tf with
        %initial conditions yo. Each row in the solution array y corresponds
        %to a value returned in column vector t
    
else
        [t,h] = ode45(@(t,h) hlinevolplandessus3d_s(t,h,s,L),[0 tmax],h0,options);
        %solver for non-stiff dirential equations - medium order method
        %[t,y]=ode45(odefun,tspan,yo), where tspan= (to tf) integrates
        %the system of differential equations y'=f(y,t) from to to tf with
        %inital conditions yo. Each row in the solution array y corresponds
        %to a value returned in column vector t
end
size(h)
size(t)
size(s)

%t
%h1=cat(2,h1,h)
%h1
%end
cpuTime = cputime()-cpuTime;
disp(['CPU time = ' num2str(cpuTime)]);
%h
%t
itmax = length(t);

%h is 201x100

%% Results visualization

ampliFactor = 1000; % just for visualisation purposes
timeStretching = 1; % streching factor for spatio-temporal diagram

%size(trapz(thetaX,h0,2))
%size(thetaY)
massI = trapz(thetaY,trapz(thetaX,h0,2));
massI



%size(repmat(s,size(t)))
%reshape h, which is before this line a vector
%h1 is th reshqped version
h1=[];
for i=1:length(t)
    h1=[h1;reshape(h(i,:),[sqrt(size(h,2)),sqrt(size(h,2))])];
end
h1=h1';
size(h1)
size(repmat(s,size(t')))
%length(t)
%s
%repmat(s,size(t))
%size(t)

hh=h1+repmat(s,size(t')); %B = repmat(A,n) returns an array containing n copies of A in the row and column dimensions. The size of B is size(A)*n when A is a matrix.
maxhh=max(hh');%use of maxhh?
%hh
v = VideoWriter('level.mp4');
open(v);

%set(gca,'nextplot','replacechildren'); 


for it = 1:itmax % "animation..."
    if(true)
    figure(1)
    view(3);
    %length(thetaY)
    %thetaX
    %thetaY
    repelem(thetaX,length(thetaY))
    repmat(thetaY',1,length(thetaX))'
    reshape(s,size(s,1)*size(s,2),1)
    it
    %hh((it:it+size(s,1)-1),:)
    scatter3(repelem(thetaX,length(thetaY)),repmat(thetaY',1,length(thetaX))',reshape(s,1,size(s,1)*size(s,2)),'r');
    %plot(theta,s,'r');
    %a alternative to plot3 is surf
    hold on;
    scatter3(repelem(thetaX,length(thetaY)),repmat(thetaY',1,length(thetaX))',reshape(hh((it:it+size(s,1)-1),:),1,size(s,1)*size(s,2)),'b');
    hold off;
    xlabel('\thetaX');
    ylabel('\thetaY');
    zlabel('height');
    axis([thetaX(1) thetaX(end) thetaY(1) thetaY(end) min(min(s))-0.05 max(max(hh))+0.05]);
    title(['t = ' num2str(t(it))]);
    drawnow
    frame = getframe(gcf);
    writeVideo(v,frame);

    end
    
    
    mass = trapz(thetaY,trapz(thetaX,hh((it:it+size(s,1)-1),:),2));
    relMassError = abs(massI-mass)/mass;
    if(relMassError*100>0.1)%0.1
        disp(['ATTENTION: mass error is: ' num2str(relMassError)]);
    end
            
end

close(v);
