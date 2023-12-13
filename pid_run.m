function pid_run(theta1,theta2, d3, theta4, t1, t2, t3, t4)
% t = [t1(end), t2(end), t3(end), t4(end)];
% t = max(t);

sig1 = [t1;theta1];
sig2 = [t2;theta2];
sig3 = [t3;d3];
sig4 = [t4;theta4];

save setpoint_theta1.mat sig1;
save setpoint_theta2.mat sig2;
save setpoint_d3.mat sig3;
save setpoint_theta4.mat sig4;

set_param('PID_joint1','StopTime',num2str(t1(end)));
set_param('PID_joint1','SimulationCommand','start');

set_param('PID_joint2','StopTime',num2str(t2(end)));
set_param('PID_joint2','SimulationCommand','start');

set_param('PID_joint3','StopTime',num2str(t3(end)));
set_param('PID_joint3','SimulationCommand','start');

set_param('PID_joint4','StopTime',num2str(t4(end)));
set_param('PID_joint4','SimulationCommand','start');
end

