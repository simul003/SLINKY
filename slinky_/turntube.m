function [turn_tube, bend] = turntube(points_per_mm, tube_dia, Coil_Radious, slinky_coil);
%  slinky_coil
z_ = -(Coil_Radious*2 + tube_dia); 
turn_tube            = [      slinky_coil(1,end),      slinky_coil(1, 1) ;
                              slinky_coil(2,end),      slinky_coil(2, 1) ;
                         z_ + slinky_coil(3,end), z_ + slinky_coil(3, 1)];



bend_center          = [  (slinky_coil(1,end) + turn_tube(1, 1))/2 ;
                          (slinky_coil(2,end) + turn_tube(2, 1))/2 ;
                          (slinky_coil(3,end) + turn_tube(3, 1))/2];


points              =       ceil(pi*Coil_Radious*points_per_mm);
t                   =               linspace(pi/2, -pi/2, points);
r_                  =                  Coil_Radious + .5*tube_dia;

bend                =  [ bend_center(1) + r_ * cos(t) ;
                         bend_center(2)*ones(1,points);
                         bend_center(3) + r_ * sin(t)];
    
                            


end