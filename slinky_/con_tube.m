function [inlet, bend_in, outlet, bend_out] = con_tube(dept, dept_bend_radious, turn_tube_coord, slinky_coord, points_per_mm)
    
if dept_bend_radious<=0
    inlet =[];
    outlet =[];
    bend_in = [];
    bend_out = [];

    return
end

    % Number of points for the bend
    points = ceil(pi * 0.5 * dept_bend_radious * points_per_mm);

    % Inlet bend calculation
    [c_in, n] = center(slinky_coord(:,end), slinky_coord(:,1), turn_tube_coord(:,1), dept_bend_radious);
    t = linspace(pi, 3*pi/2, points);
    bend_in(1,:) = c_in(1) + dept_bend_radious * cos(t);
    bend_in(2,:) = c_in(2) + dept_bend_radious * sin(t);     
    bend_in(3,:) = ones(1, points) * c_in(3);
    
    % Outlet bend calculation
    [c_out, n] = center(slinky_coord(:,1), turn_tube_coord(:,end), turn_tube_coord(:,1), dept_bend_radious);
    t = linspace(3*pi/2, pi, points);
    bend_out(1,:) = c_out(1) + dept_bend_radious * cos(t);
    bend_out(2,:) = c_out(2) + dept_bend_radious * sin(t);     
    bend_out(3,:) = ones(1, points) * c_out(3);
    

if dept_bend_radious>=0 dept
    inlet =[];
    outlet =[];
    return
end
    inlet = [ bend_in(:,1) + (dept - dept_bend_radious) * n, bend_in(:,1)] ;
    outlet = [ bend_out(:,end), bend_out(:,end) + (dept - dept_bend_radious) * n, ];

    % Subfunction to calculate the center
    function [D, n] = center(A, B, C, d)
        AB = B - A;
        CB = B - C;
        n = cross(AB, CB);
        n = n / norm(n); % Normalize
        D = B + d * n;
    end

end
