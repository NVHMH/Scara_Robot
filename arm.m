classdef arm
    %%
    properties
        a, alpha, d, theta 
        n, base, type
        x, T, end_effector
    end
    %%
    methods
        function obj = arm(a, alpha, d, theta, base, type)
            obj.a = a;
            obj.alpha = deg2rad(alpha);
            obj.d = d;
            obj.theta = deg2rad(theta);
            obj.base = base;
            obj.type = type;
            obj.n = 4;
        end
        %%
        function obj = update(obj)
            obj.T = forward_kinematics(obj.n, obj.a, obj.alpha, obj.d, obj.theta);
            for i = 1:obj.n+1
                obj.x(:,i) = (obj.T(1:3,4,i)) + obj.base;
            end
            obj.end_effector = [obj.x(:,obj.n+1); tform2eul(obj.T(:,:,obj.n+1))'];
        end
        %%
        function obj = set_joint_variable(obj, index, q)
            if obj.type(index) == 'r'   %revolute - xoay
                obj.theta(index) = q;
            elseif obj.type(index) == 'p'   %prismatic - truot
                obj.d(index) = q;
            end
        end
        %%
        function plot_arm(obj, axes)
            %% Parameters
            opacity = 0.2;
            COLOR_GRAY =  [139 137 137]/255;
            COLOR_PINK = [238 106 167]/255;
            COLOR_RED = [205 200 177]/255;
            COLOR_GREEN = [0.3, 0.7, 0.3];
            COLOR_BLUE = [0.3, 0.7, 0.7];
            %% base 
            R1 = 0.07;
            H1 = 0.179;
            
            th = linspace(-pi, pi, 100);
            X = R1*cos(th) + obj.x(1,1);
            Y = R1*sin(th) + obj.x(2,1);
            Z1 = ones(1, size(th, 2))*obj.x(3,1);
            Z2 = ones(1, size(th, 2))*H1;
            
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_GRAY, 'EdgeColor', 'none', 'FaceAlpha', opacity)
            fill3(axes, X, Y, Z1, COLOR_GRAY, 'FaceAlpha', opacity);
            fill3(axes, X, Y, Z2, COLOR_GRAY, 'FaceAlpha', opacity);
            %% link 1
            H2 = 0.072;
            W2 = 1.2*R1;
            L2 = obj.a(1);
            R2 = W2/2;
            
            X = obj.x(1,1);
            Y = obj.x(2,1);
            Z1 = obj.x(3,2)-H2;
            Z2 = obj.x(3,2);
            yaw = obj.theta(1);
            fill3(axes, [X-W2/2*sin(yaw), X+W2/2*sin(yaw), X+L2*cos(yaw)+W2/2*sin(yaw), X+L2*cos(yaw)-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y-W2/2*cos(yaw), Y+L2*sin(yaw)-W2/2*cos(yaw), Y+L2*sin(yaw)+W2/2*cos(yaw)], [Z1, Z1, Z1, Z1], COLOR_GREEN, 'FaceAlpha', opacity)
            fill3(axes, [X-W2/2*sin(yaw), X+W2/2*sin(yaw), X+L2*cos(yaw)+W2/2*sin(yaw), X+L2*cos(yaw)-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y-W2/2*cos(yaw), Y+L2*sin(yaw)-W2/2*cos(yaw), Y+L2*sin(yaw)+W2/2*cos(yaw)], [Z2, Z2, Z2, Z2], COLOR_GREEN, 'FaceAlpha', opacity)
            fill3(axes, [X+W2/2*sin(yaw), X+W2/2*sin(yaw)+L2*cos(yaw), X+W2/2*sin(yaw)+L2*cos(yaw), X+W2/2*sin(yaw)], [Y-W2/2*cos(yaw), Y+L2*sin(yaw)-W2/2*cos(yaw), Y+L2*sin(yaw)-W2/2*cos(yaw), Y-W2/2*cos(yaw)], [Z1, Z1, Z2, Z2], COLOR_GREEN, 'FaceAlpha', opacity)
            fill3(axes, [X-W2/2*sin(yaw), X-W2/2*sin(yaw)+L2*cos(yaw), X-W2/2*sin(yaw)+L2*cos(yaw), X-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y+L2*sin(yaw)+W2/2*cos(yaw), Y+L2*sin(yaw)+W2/2*cos(yaw), Y+W2/2*cos(yaw)], [Z1, Z1, Z2, Z2], COLOR_GREEN, 'FaceAlpha', opacity)
            
            th = linspace(pi+yaw-pi/2, 2*pi+yaw-pi/2, 100);
            X = R2*cos(th) + obj.x(1,1);
            Y = R2*sin(th) + obj.x(2,1);
            Z1 = ones(1,size(th,2))*(obj.x(3,2) - H2);
            Z2 = ones(1,size(th,2))*obj.x(3,2);
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_GREEN, 'EdgeColor', 'none', 'FaceAlpha', opacity)
            fill3(axes, X, Y, Z1, COLOR_GREEN, 'FaceAlpha', opacity);
            fill3(axes, X, Y, Z2, COLOR_GREEN, 'FaceAlpha', opacity);
            
            th = linspace(0+yaw-pi/2, pi+yaw-pi/2, 100);
            X = R2*cos(th) + obj.x(1,2);
            Y = R2*sin(th) + obj.x(2,2);
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_GREEN, 'EdgeColor', 'none', 'FaceAlpha', opacity)
            fill3(axes, X, Y, Z1, COLOR_GREEN, 'FaceAlpha', opacity);
            fill3(axes, X, Y, Z2, COLOR_GREEN, 'FaceAlpha', opacity);
            %% link2
            H3 = 0.1;
            L3 = obj.a(2);
            
            X = obj.x(1,2);
            Y = obj.x(2,2);
            Z1 = obj.x(3,2);
            Z2 = obj.x(3,2) + H3;
            yaw = (obj.theta(1)+obj.theta(2));
            
            fill3(axes, [X-W2/2*sin(yaw), X+W2/2*sin(yaw), X+L3*cos(yaw)+W2/2*sin(yaw), X+L3*cos(yaw)-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y-W2/2*cos(yaw), Y+L3*sin(yaw)-W2/2*cos(yaw), Y+L3*sin(yaw)+W2/2*cos(yaw)], [Z1, Z1, Z1, Z1], COLOR_BLUE, 'FaceAlpha', opacity)
            fill3(axes, [X-W2/2*sin(yaw), X+W2/2*sin(yaw), X+L3*cos(yaw)+W2/2*sin(yaw), X+L3*cos(yaw)-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y-W2/2*cos(yaw), Y+L3*sin(yaw)-W2/2*cos(yaw), Y+L3*sin(yaw)+W2/2*cos(yaw)], [Z2, Z2, Z2, Z2], COLOR_BLUE, 'FaceAlpha', opacity)
            fill3(axes, [X+W2/2*sin(yaw), X+W2/2*sin(yaw)+L3*cos(yaw), X+W2/2*sin(yaw)+L3*cos(yaw), X+W2/2*sin(yaw)], [Y-W2/2*cos(yaw), Y+L3*sin(yaw)-W2/2*cos(yaw), Y+L3*sin(yaw)-W2/2*cos(yaw), Y-W2/2*cos(yaw)], [Z1, Z1, Z2, Z2], COLOR_BLUE, 'FaceAlpha', opacity)
            fill3(axes, [X-W2/2*sin(yaw), X-W2/2*sin(yaw)+L3*cos(yaw), X-W2/2*sin(yaw)+L3*cos(yaw), X-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y+L3*sin(yaw)+W2/2*cos(yaw), Y+L3*sin(yaw)+W2/2*cos(yaw), Y+W2/2*cos(yaw)], [Z1, Z1, Z2, Z2], COLOR_BLUE, 'FaceAlpha', opacity)
            
            th = linspace(pi+yaw-pi/2, 2*pi+yaw-pi/2, 100);
            X = R2*cos(th) + obj.x(1,2);
            Y = R2*sin(th) + obj.x(2,2);
            Z1 = ones(1,size(th,2))*obj.x(3,2);
            Z2 = ones(1,size(th,2))*(obj.x(3,2) + H3);
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_BLUE, 'EdgeColor', 'none', 'FaceAlpha', opacity);
            fill3(axes, X , Y , Z1, COLOR_BLUE, 'FaceAlpha', opacity);
            fill3(axes, X , Y , Z2, COLOR_BLUE, 'FaceAlpha', opacity);
            
            th = linspace(0+yaw-pi/2, pi+yaw-pi/2, 100);
            X = R2*cos(th) + obj.x(1,3);
            Y = R2*sin(th) + obj.x(2,3);
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_BLUE, 'EdgeColor', 'none', 'FaceAlpha', opacity);
            fill3(axes, X , Y , Z1, COLOR_BLUE, 'FaceAlpha', opacity);
            fill3(axes, X , Y , Z2, COLOR_BLUE, 'FaceAlpha', opacity);
            
            %% link3
            R3 = 0.01;
            H31 = 0.35;
            H32 = -obj.d(4);
            
            th = linspace(-pi, pi, 100);
            X = R3*cos(th) + obj.x(1,4);
            Y = R3*sin(th) + obj.x(2,4);
            Z1 = ones(1, size(th, 2))*(obj.x(3,4)-H32);
            Z2 = ones(1, size(th, 2))*(obj.x(3,4)+H31-H32);
            
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_PINK, 'EdgeColor', 'none', 'FaceAlpha', opacity)
            fill3(axes, X, Y, Z1, COLOR_PINK, 'FaceAlpha', opacity);
            fill3(axes, X, Y, Z2, COLOR_PINK, 'FaceAlpha', opacity);
            
            %% end effector
            R4 = 0.02;
            H4 = 0.01;
            
            th = linspace(-pi, pi, 100);
            X = R4*cos(th) + obj.x(1,5);
            Y = R4*sin(th) + obj.x(2,5);
            Z1 = ones(1, size(th, 2))*(obj.x(3,5)-H4);
            Z2 = ones(1, size(th, 2))*obj.x(3,5);
            
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_RED, 'EdgeColor', 'none', 'FaceAlpha', opacity)
            fill3(axes, X, Y, Z1, COLOR_RED, 'FaceAlpha', opacity);
            fill3(axes, X, Y, Z2, COLOR_RED, 'FaceAlpha', opacity);
        end 
        %%
        function plot_coords(obj, axes)
            vx = zeros(3, obj.n);
            vy = zeros(3, obj.n);
            vz = zeros(3, obj.n+1);
            for i = 1:obj.n+1
                vx(:,i) = obj.T(1:3,1:3,i)*[1; 0; 0];
                vy(:,i) = obj.T(1:3,1:3,i)*[0; 1; 0];
                vz(:,i) = obj.T(1:3,1:3,i)*[0; 0; 1];
            end
          
            % Plot ref frame of each joint
            axis_scale = 1/3;
            quiver3(axes, obj.x(1,:), obj.x(2,:), obj.x(3,:), vx(1,:), vx(2,:), vx(3,:), axis_scale, 'r', 'LineWidth', 2);
            quiver3(axes, obj.x(1,:), obj.x(2,:), obj.x(3,:), vy(1,:), vy(2,:), vy(3,:), axis_scale, 'g', 'LineWidth', 2);
            quiver3(axes, obj.x(1,:), obj.x(2,:), obj.x(3,:), vz(1,:), vz(2,:), vz(3,:), axis_scale, 'b', 'LineWidth', 2);
        end
        

        
        %% 
        function plot(obj, axes, coords)
            cla(axes);
            hold on;
            rotate3d(axes, 'on');
            xlabel(axes, 'x (m)');
            ylabel(axes, 'y (m)'); 
            zlabel(axes, 'z (m)');
            xlim(axes, [-0.7 0.7]);
            ylim(axes, [-0.7 0.7]);
            zlim(axes, [0  0.7]);
            obj.plot_arm(axes);
            if coords
                obj.plot_coords(axes);
            end
            view(axes, 3);
            drawnow;
         end
    end
 end
