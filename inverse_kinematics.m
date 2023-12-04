 function q = inverse_kinematics(a, alpha, d, theta, end_effector)
    % [x; y; z; roll; pitch; yaw] = end_effector
    % [theta1; theta2; d3; theta4] = q
    
    s = end_effector(1)^2 + end_effector(2)^2;
    % Check condition
    if sqrt(s) > a(1) + a(2) || sqrt(s) < abs(a(1) - a(2))
        warndlg('Inverse Kinematics Condition!', 'Warning');
        return
    end
   
    c2 = (s - a(1)^2 - a(2)^2)/(2*a(1)*a(2));
    s2 = sqrt(1 - c2^2);
    q(2) = atan2(s2, c2);
    s1 = ((a(1)+a(2)*c2)*end_effector(2) - a(2)*s2*end_effector(1))/s;
    c1 = ((a(1)+a(2)*c2)*end_effector(1) + a(2)*s2*end_effector(2))/s;
    q(1) = atan2(s1, c1);
    q(4) = wrapTo2Pi(-q(1) - q(2) + end_effector(6));
    q(3) = end_effector(3) - d(1) -d(2) -d(4);
    
    % Check condition
    if (q(1) > deg2rad(125))
        q(1) = deg2rad(125);
        warndlg('Inverse Kinematics Condition!', 'Warning');
    elseif (q(1) < deg2rad(-125))
        q(2) = deg2rad(-125);
        warndlg('Inverse Kinematics Condition!', 'Warning');
    end
    
    if (q(2) > deg2rad(148))
        q(2) = deg2rad(148);
        warndlg('Inverse Kinematics Condition!', 'Warning');
    elseif (q(2) < deg2rad(-148))
        q(2) = deg2rad(-148);
        warndlg('Inverse Kinematics Condition!', 'Warning');
    end
    
    if (q(3) > 0)
        q(3) = 0;
        warndlg('Inverse Kinematics Condition!', 'Warning');
    elseif (q(2) < -0.15)
        q(2) = -0.15;
        warndlg('Inverse Kinematics Condition!', 'Warning');
    end
    

end