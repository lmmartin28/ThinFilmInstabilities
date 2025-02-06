function [dh_dt] = hevolplandessus3d_s(t,h1,s,L,i)

%if rem(100*t,1)==0 disp(t); end;

%disp(t)

h=reshape(h1,[10,10]);

hX1 = fourdifft3d(h,1)*2*pi/L;
hX2 = fourdifft3d(h,2)*2*pi/L;
hX3 = fourdifft3d(h,3)*2*pi/L;
hX4 = fourdifft3d(h,4)*2*pi/L;

%size(hX1)
%size(hX2)
%size(hX3)
%size(hX4)

hY1 = (fourdifft3d(h',1)')*2*pi/L;
hY2 = (fourdifft3d(h',2)')*2*pi/L;
hY3 = (fourdifft3d(h',3)')*2*pi/L;
hY4 = (fourdifft3d(h',4)')*2*pi/L;

%size(hY1)
%size(hY2)
%size(hY3)
%size(hY4)

%hX1Y1=(fourdifft3d(hX1',1)')*2*pi/L;
hX1Y2=(fourdifft3d(hX1',2)')*2*pi/L;
%hX1Y3=(fourdifft3d(hX1',3)')*2*pi/L;

%size(hX1Y2)

hX2Y1 = fourdifft3d(hY1,2)*2*pi/L;
%%hX3Y1 = fourdifft3d(hY1,3)*2*pi/L;

%size(hX2Y1)

hX2Y2 = fourdifft3d(hY2,2)*2*pi/L;

%size(hX2Y2)

sX1 = fourdifft3d(s,1)*2*pi/L;
sX2 = fourdifft3d(s,2)*2*pi/L;
sX3 = fourdifft3d(s,3)*2*pi/L;
sX4 = fourdifft3d(s,4)*2*pi/L;

%size(s)
%size(sX1)
%size(sX2)
%size(sX3)
%size(sX4)

sY1 = (fourdifft3d(s',1)')*2*pi/L;
sY2 = (fourdifft3d(s',2)')*2*pi/L;
sY3 = (fourdifft3d(s',3)')*2*pi/L;
sY4 = (fourdifft3d(s',4)')*2*pi/L;

%size(sY1)
%size(sY2)
%size(sY3)
%size(sY4)

%sX1Y1=(fourdifft3d(sX1',1)')*2*pi/L;
sX1Y2=(fourdifft3d(sX1',2)')*2*pi/L;
%sX1Y3=(fourdifft3d(sX1',3)')*2*pi/L;
%size(sX1Y2)
sX2Y1 = fourdifft3d(sY1,2)*2*pi/L;
%sX3Y1 = fourdifft3d(sY1,3)*2*pi/L;
%size(sX2Y1)
sX2Y2 = fourdifft3d(sY2,2)*2*pi/L;

%hX1 = hX1(:,i);
%hX2 = hX2(:,i);
%hX3 = hX3(:,i);
%hX4 = hX4(:,i);

%sX1 = hX1(:,i);
%sX2 = hX2(:,i);
%sX3 = hX3(:,i);
%sX4 = hX4(:,i);
%h=h(:,i);
%s=s(:,i);
%dh_dt = -h.^2.*h1.*h3-h.^2.*h1.*s3 - 1/3.*h.^3.*h4 - 1/3.*h.^3.*s4;
%dh_dt = (-h.^2.*h1.*h3-h.^2.*h1.*s3 - 1/3.*h.^3.*h4 - 1/3.*h.^3.*s4)-0.001.*(-(1./(h.^2)).*(h1.^2)+(1./h).*(h2));
%adim eq. dh/dt=1/3 (3h^2 D1h D3h +3h^2 D1h D3s + h^3 D4h + h^3 D4s)
dh=(6.*h.*((hX1).^2).*(hX2+sX2));
%+(3.*(h.^2).*(hX3+sX3).*hX1);%+(3.*(h.^2).*(hX2+sX2).*(hX2))+(3*(h.^2).*(hX3+sX3).*hX1)+((h.^3).*(hX4+sX4))+(6*h.*(hX1.^2).*(hY2+sY2))+(3*(h.^2).*(hX2).*(hY2+sY2))+(3*(h.^2).*(hX1).*(hX1Y2+sX1Y2))+(3*h.^2.*hX1.*(hX1Y2+sX1Y2))+((h.^3).*(hX2Y2+sX2Y2))+(6*h.*(hY1.^2).*(hX2+sX2))+(3*(h.^2).*(hY2.^2).*(hX2+sX2))+(3*(h.^2).*(hY1).*(hX2Y1+sX2Y1))+(6*h.*(hY1.^2).*(hY2+sY2))+(3*(h.^2).*(hY2).*(hY2+sY2))+(3*(h.^2).*(hY1).*(hX1Y2+sX1Y2))+(3*(h.^2).*(hY1).*(hX2Y1+sX2Y1))+((h.^3).*(hX2Y2+sX2Y2))+(3*(h.^2).*(hY1).*(hY3+sY3))+((h.^3).*(hY4+sY4));
dh_dt=reshape(dh,[size(dh,1)*size(dh,2),1]);
%dh_dt
return
