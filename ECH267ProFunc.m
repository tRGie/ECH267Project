function [ds,ext] = ECH267ProFunc(t,s)
global del_max v lf lr
e_ct = s(1);
yaw = s(2);
x = s(3);
y = s(4);

k = 5;
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
x_dot = v*cos(yaw);
y_dot = v*sin(yaw);
ds = [e_ct_dot; yaw_dot; x_dot; y_dot];
ext = del;