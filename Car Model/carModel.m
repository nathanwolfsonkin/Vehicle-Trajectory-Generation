%DEVELOPING A MODEL FOR A CAR TO DRIVE TO A CERTAIN POSITION WITH A CERTAIN
%ANGLE

clear all; close all; clc;

%CAR AND SIMULATION CONSTANTS
T = 10;                         % [s]
L = 2.7;                        % [m]
[fig,x0,y0,theta0,xf,yf,thetaf] = generateFigure();

%DEFINE TRAJECTORY
time = 0:.01:T;
time = time';

%DEFINE REFERENCE TRAJECTORY AS A 5TH ORDER POLYNOMIAL IN X AND Y
%DIRECTIONS
s = 1;
InputMatrix = [  0       0       0      0     0    1;
                 0       0       0      0     1    0;
                 0       0       0      2     0    0;
                T^5     T^4     T^3    T^2    T    1;
               5*T^4   4*T^3   3*T^2   2*T    1    0;
               20*T^3 12*T^2   6*T      2     0    0];
xInputVect = [x0  0  s*cos(theta0)  xf  0  s*cos(thetaf + pi)]';
xPoly = InputMatrix\xInputVect;
xPos = polyval(xPoly,time(:,1));
xTrajectory = [time,xPos];

yInputVect = [y0  0  s*sin(theta0)  yf  0  s*sin(thetaf + pi)]';
yPoly = InputMatrix\yInputVect;
yPos = polyval(yPoly,time(:,1));
yTrajectory = [time,yPos];

%CALCULATE ALL REQUIRED STATES BASED ON GENERATED TRAJECTORY

%CALCULATE DESIRED VELOCITIES IN X AND Y DIRECTIONS
xVel = polyval(polyder(xPoly),time);
yVel = polyval(polyder(yPoly),time);

%CALCULATE DESIRED ACCELERATIONS IN X AND Y DIRECTIONS
xAccel = polyval(polyder(polyder(xPoly)),time);
yAccel = polyval(polyder(polyder(yPoly)),time);

%CALCULATE DESIRED THETA
thetad = atan2(yVel,xVel);

%CALCULATE DESIRED DTHETA
dthetad = (1./((yVel./xVel).^2 + 1)) .* ((xVel.*yAccel - yVel.*xAccel) ./ (xVel.^2));

%CALCULATE DESIRED VELOCITY VECTOR
index = 0;
for i = time'
    index = index + 1;
    try
        vd(index) = xVel(index)./cos(thetad(index));
    catch
        vd(index) = yVel(index)./sin(thetad(index));
    end
end
vd = vd';

deld = atan(dthetad.*L./vd);
%%
%FORMATTING
time = time(1:length(time)-1,1);
vd = vd(1:length(vd)-1,1);
deld = deld(1:length(deld)-1,1);
xPos = xPos(1:length(xPos)-1,1);
yPos = yPos(1:length(yPos)-1,1);
thetad = thetad(1:length(thetad)-1,1);


%PLOT DESIRED VELOCITIES
subplot(2,2,2);
hold on;
h1=gca;h1.FontSize=18;h1.LineWidth=2;
plot(time,vd,'r','LineWidth',2)
title('Desired Velocity Magnitude')
% xlabel('Time (s)')
ylabel('Velocity (m/s)')

%PLOT DESIRED STEERING ANGLES
subplot(2,2,4);
hold on;
h2=gca;h2.FontSize=18;h2.LineWidth=2;
plot(time,deld*180/pi,'r','LineWidth',2)
title('Desired Steering Angle')
xlabel('time (s)')
ylabel('Steering Angle (°)')

%DRAW CAR DRIVING OVER DESIRED TRAJECTORY
animateCar(xPos,yPos,theta0,time,fig,xPos,yPos,thetad)