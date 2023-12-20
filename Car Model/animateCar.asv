function [] = animateCar(xTraj,yTraj,theta0,time,fig,xDesired,yDesired,angleTraj)

figure(fig);
subplot(2,2,[1 3]);
h=gca;h.LineWidth=2;h.FontSize=18;h.DataAspectRatio=[1,1,1];
hold on;


if exist('xDesired','var') == 1 && exist('yDesired','var') == 1
    title('Desired Trajectory')
    plot(xDesired,yDesired,'Color',[0,0,0,.3],'LineWidth',2)   
    hold off;
    pause(5)
    plot(xDesired,yDesired,'Color',[0,0,0,.3],'LineWidth',2)
    h=gca;h.LineWidth=2;h.FontSize=18;h.DataAspectRatio=[1,1,1];
    hold on;
end

%ANIMATE CAR
hold on;
if exist('plotPath','var') == 1
    desiredPos = plot(nsidedpoly(1000,'Center',[xDesired(1),yDesired(1)],'Radius',.1),'FaceColor','g','faceAlpha',1);
end

%DETERMINE AXIS LIMITS
xmax = max(max(max(xTraj),max(xDesired)) + 1,10);
xmin = min(min(min(xTraj),min(xDesired)) - 1,-10);
ymax = max(max(max(yTraj),max(yDesired)) + 1,10);
ymin = min(min(min(yTraj),min(yDesired)) - 1,-10);
xlim([xmin,xmax]);
ylim([ymin,ymax]);

% -----------------------------------------------------------------------------------------------------
carScaling  = .2;
sizeRatio   = 1.5;    %RATIO OF HEIGHT TO WIDTH
carCenter0 = [xTraj(1);yTraj(1)];

leftFront   = [-carScaling*sizeRatio ; carScaling] + carCenter0;
rightFront  = [carScaling*sizeRatio  ; carScaling] + carCenter0;
leftBack    = [-carScaling*sizeRatio ; -carScaling] + carCenter0;
rightBack   = [carScaling*sizeRatio  ; -carScaling] + carCenter0;

rotationMat = [cos(theta0),-sin(theta0);sin(theta0),cos(theta0)];
leftFront   = rotationMat*(leftFront - carCenter0) + carCenter0;
rightFront  = rotationMat*(rightFront - carCenter0) + carCenter0;
leftBack    = rotationMat*(leftBack - carCenter0) + carCenter0;
rightBack   = rotationMat*(rightBack - carCenter0) + carCenter0;


car = polyshape([leftFront(1),rightFront(1),rightBack(1),leftBack(1)],...
                [leftFront(2),rightFront(2),rightBack(2),leftBack(2)]);

carPlot = plot(car,'FaceColor','red','EdgeColor','k','LineWidth',2,'FaceAlpha',1);
carPath = plot(xTraj(1),yTraj(1),'k','LineWidth',2);
for i = 2:3:length(xTraj)
    if exist('plotPath','var')
        delete(desiredPos)
        desiredPos = plot(nsidedpoly(1000,'Center',[xDesired(i),yDesired(i)],'Radius',.1),'FaceColor','g','faceAlpha',1);
    end
    delete(carPath)
    carPath = plot(xTraj(1:i),yTraj(1:i),'k','LineWidth',2,'LineStyle','--');
    uistack(carPlot,'top');
    carCenter = [xTraj(i);yTraj(i)];
    rotationMat = [cos(angleTraj(i)-theta0),-sin(angleTraj(i)-theta0);sin(angleTraj(i)-theta0),cos(angleTraj(i)-theta0)];
    rotLeftFront   = rotationMat * (leftFront - carCenter0) + carCenter;
    rotRightFront  = rotationMat * (rightFront - carCenter0) + carCenter;
    rotLeftBack    = rotationMat * (leftBack - carCenter0) + carCenter;
    rotRightBack   = rotationMat * (rightBack - carCenter0) + carCenter;
    
    temp = [rotLeftFront(1),rotLeftFront(2);rotRightFront(1),rotRightFront(2);...
            rotRightBack(1),rotRightBack(2);rotLeftBack(1),rotLeftBack(2)];
    carPlot.Shape.Vertices = temp;
    drawnow;
    pause(.001)
    title(['time: ' num2str(time(i))])
end