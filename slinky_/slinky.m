function slinky_coil = slinky(points_per_mm, tube_dia, Coil_Radious, Revolution, length);

pitch               =           length/ Revolution;
Angle               =         asin(tube_dia/pitch);
slinky_tube_length  = 2*pi*Coil_Radious*Revolution;

points              =              ceil(slinky_tube_length*points_per_mm);
phase               =                                                pi/2;
t                   = linspace(phase, Revolution * 2 * pi+ phase, points);  % Parameter t
 
% Original parametric equations for the slinky
x                   =  pitch * t / (2 * pi);             % Moves along the x-axis
y                   = Coil_Radious * cos(t);             % Circular motion in the y-direction
z                   = Coil_Radious * sin(t);             % Circular motion in the z-direction

% Define the custom transformation matrix
theta_xy            = pi - Angle;                        % Angle between X' and Y' ( radians)
theta_xz            =       pi/2;                        % Angle between X' and Z' (90 degrees)
theta_yz            =       pi/2;                        % Angle between Y' and Z' (90 degrees)

% Transformation matrix for custom coordinate system
T                   = [1, cos(theta_xy),             0;
                       0, sin(theta_xy), cos(theta_yz);
                       0,             0, sin(theta_xz)];

% Apply the transformation to each point
slinky_coil          =    T * [x; y; z];
slinky_coil(2, end)  = slinky_coil(2, 1);
slinky_coil(3, end)  = slinky_coil(3, 1);

end
