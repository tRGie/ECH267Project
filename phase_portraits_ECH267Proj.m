function phase_portraits()
close all
clc

tspan = linspace(0,5,50);
f = figure;
xlabel('x_1')
ylabel('x_2')
hold on
for x10 = -5:1:5
    for x20 = -5:1:5
        xinitials = [x10;x20];
        [tout,sout] = ode45(@derivatives,tspan,xinitials);
        x1out = sout(:,1);
        x2out = sout(:,2);
        plot(x1out,x2out)
        u = gradient(x1out);v = gradient(x2out);quiver(x1out,x2out,u,v);
        axis([-3 3 -3 3])
        drawnow
    end
end

function dsdt = derivatives(t,s)
global del_max v lf lr
del_max = 30*pi/180;
v = 5;
L = 7*.3048; %wheelbase
l_fl_r = 0.85; %a/b
lr = L/(1+l_fl_r);
lf = L-lr;
e_ct = s(1);
yaw = s(2);

k = 0.5;
del = yaw+atan((k*e_ct)/(v));
if abs(del) < del_max
    del = yaw+atan((k*e_ct)/(v));
elseif del >= del_max
    del = del_max;
elseif del <= -del_max
    del = -del_max;
end

e_ct_dot = v*sin(yaw-del);
yaw_dot = -(v*sin(del))/(lf+lr);
dsdt = [e_ct_dot; yaw_dot];

