%close all 
clear
clc
global del_max v L lf lr
del_max = 30*pi/180;
v = 5;
L = 2; %wheelbase
l_fl_r = 0.85; %a/b
lr = L/(1+l_fl_r);
lf = L-lr;

x0 = 0;
y0 = 5;
yaw0 = 0;
e0 = y0+L*sin(yaw0);
initial = [e0 yaw0 x0 y0];
tspan = linspace(0,15,301);
[t,s] = ode45(@ECH267ProFunc,tspan,initial);
ext = zeros(length(t),1);
ds = zeros(length(t),4);
for i = 1:length(t)
    [ds(i,:),ext(i,:)] = ECH267ProFunc(t(i),s(i,:));
end

tiledlayout(2,2)
nexttile
plot(t,s(:,1))
title('Crosstrack Error')
xlabel('time(s)')
ylabel('e_crosstrack(m)')
nexttile
plot(t,s(:,2)*180/pi)
title('Yaw')
xlabel('time(s)')
ylabel('Yaw Angle(degree)')
nexttile
plot(s(:,3),s(:,4))
title('Car Model Position')
xlabel('x(m)')
ylabel('y(m)')
nexttile
plot(t,ext)
title('Delta Input')
xlabel('time(s)')
ylabel('turning angle(degree)')

