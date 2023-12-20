%DEVELOPING A MODEL FOR A CAR TO DRIVE TO A CERTAIN POSITION WITH A CERTAIN
%ANGLE

clear all; close all; clc;

%CONTROLLER VALUES
Kpx = 10000;
Kix = 10000;
Kdx = 10000;

Kpy = 10000;
Kiy = 10000;
Kdy = 10000;

%CAR AND SIMULATION CONSTANTS
T           = 10;
thetaMax    = pi/4; % [Radians]
m           = 1500; % [Kg]

[fig,x0,y0,theta0,xf,yf,thetaf] = generateFigure();

%DEFINE TRAJECTORY
time = 0:.01:T;
time = time';

%DEFINE REFERENCE TRAJECTORY AS A 5TH ORDER POLYNOMIAL IN X AND Y
%DIRECTIONS
s = 3;
InputMatrix = [  0       0       0      0     0    1;
                 0       0       0      0     1    0;
                 0       0       0      2     0    0;
                T^5     T^4     T^3    T^2    T    1;
               5*T^4   4*T^3   3*T^2   2*T    1    0;
               20*T^3 12*T^2   6*T      2     0    0];
xInputVect = [x0  0  s*cos(theta0)  xf  0  s*cos(thetaf + pi)]';
xPoly = InputMatrix\xInputVect;
xDesired = polyval(xPoly,time(:,1));
xTrajectory = [time,xDesired];

yInputVect = [y0  0  s*sin(theta0)  yf  0  s*sin(thetaf + pi)]';
yPoly = InputMatrix\yInputVect;
yDesired = polyval(yPoly,time(:,1));
yTrajectory = [time,yDesired];

%SIMULATE
out = sim('carModel_Simulation');
simX = out.position(:,1);
simY = out.position(:,2);

%DRAW CAR DRIVING OVER DESIRED TRAJECTORY
animateCar(simX,simY,theta0,time,fig,xDesired,yDesired)