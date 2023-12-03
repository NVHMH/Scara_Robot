function [t, q, v, a] = LSPB_trajectory(qmax, vmax, amax)
    if (vmax > sqrt (qmax*amax))
        vmax = sqrt (qmax*amax);
    end
    
    tc = vmax/amax;
    tf = qmax/vmax +tc;
    
    t = linspace(0, tf, 500);
    q = zeros(size(t));
    v = zeros(size(t));
    a = zeros(size(t));
    for i = 1:length(t)
        if t(i) <= tc
            q(i) = amax*t(i)^2/2;
            v(i) = amax*t(i);
            a(i) = amax;
        elseif t(i) <= tf - tc
            q(i) = 0.5*amax*tc^2+vmax*(t(i)-tc);
            v(i) = vmax;
            a(i) = 0;
        elseif t(i) <= tf
            q(i) = qmax-0.5*(vmax^2)/amax+vmax*(t(i)-tf+tc)-0.5*amax*(t(i)-tf+tc)^2;
            v(i) = vmax-amax*(t(i)-tf+tc);
            a(i) = -amax;
        end
    end
%     plot (t,q);
%     hold on;
%     plot (t,v);
%     hold on;
%     plot (t,a);
end