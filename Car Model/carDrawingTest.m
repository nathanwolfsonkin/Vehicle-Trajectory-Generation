%SCRIPT TO TEST ANIMATING CAR ROTATION
clear all;clc;

carScaling  = 1;
sizeRatio   = 1.5;    %RATIO OF HEIGHT TO WIDTH   
carCenter   = [10;10];

leftFront   = [-carScaling ; sizeRatio*carScaling] + carCenter;
rightFront  = [carScaling  ; sizeRatio*carScaling] + carCenter;
leftBack    = [-carScaling ; sizeRatio*-carScaling] + carCenter;
rightBack   = [carScaling  ; sizeRatio*-carScaling] + carCenter;

car = polyshape([leftFront(1),rightFront(1),rightBack(1),leftBack(1)],...
                [leftFront(2),rightFront(2),rightBack(2),leftBack(2)]);
figure;
hold off;
carPlot = plot(car,'FaceColor','red','EdgeColor','k','LineWidth',2,'FaceAlpha',1);
hold on;
h=gca;h.LineWidth=2;h.FontSize=18;h.DataAspectRatio=[1 1 1];
xlim([-max(carScaling,carScaling*sizeRatio) + carCenter(1), carScaling + carCenter(1) + 2])
ylim([-carScaling + carCenter(2) - 2, carScaling + carCenter(2) + 2])

for i = 0:-pi/360:-2*pi
    theta = i;
    rotationMat = [cos(theta),sin(theta);-sin(theta),cos(theta)];
    rotLeftFront   = rotationMat * (leftFront - carCenter) + carCenter;
    rotRightFront  = rotationMat * (rightFront - carCenter) + carCenter;
    rotLeftBack    = rotationMat * (leftBack - carCenter) + carCenter;
    rotRightBack   = rotationMat * (rightBack - carCenter) + carCenter;
    
    temp = [rotLeftFront(1),rotLeftFront(2);rotRightFront(1),rotRightFront(2);rotRightBack(1),rotRightBack(2);rotLeftBack(1),rotLeftBack(2)];
    carPlot.Shape.Vertices = temp;
    pause(.01)
end