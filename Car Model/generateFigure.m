function [fig,x0,y0,theta0,xf,yf,thetaf] = generateFigure()

fig = figure;
axisHandle=gca; axisHandle.LineWidth=2; axisHandle.DataAspectRatio=[1 1 1];
xlim([-10,10])
ylim([-10,10])
hold on;

title('Enter The Start Position')
[x0,y0] = ginput(1);
plot(x0,y0,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',2)
title('Enter The Starting Angle')
angleLine1 = plot([x0,x0+1],[y0,y0+1],'k','LineWidth',1,'Visible','off');
angleArc1 = plot([x0,x0+1],[y0,y0+1],'k','LineWidth',1,'Visible','off');
fig.WindowButtonMotionFcn = @(f,eve) calculateAngle(f,eve,axisHandle,angleLine1,angleArc1,x0,y0);
fig.WindowButtonDownFcn = @(f,eve) stopMouseTracking(f,eve);
waitforbuttonpress
theta0 = atan2(angleLine1.YData(2)-angleLine1.YData(1),angleLine1.XData(2)-angleLine1.XData(1));
title('Enter The Ending Position')
[xf,yf] = ginput(1);
plot(xf,yf,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',2)
title('Enter The Ending Angle')
angleLine2 = plot([x0,x0+1],[y0,y0+1],'k','LineWidth',1,'Visible','off');
angleArc2 = plot([x0,x0+1],[y0,y0+1],'k','LineWidth',1,'Visible','off');
fig.WindowButtonMotionFcn = @(f,eve) calculateAngle(f,eve,axisHandle,angleLine2,angleArc2,xf,yf);
fig.WindowButtonDownFcn = @(f,eve) stopMouseTracking(f,eve);
waitforbuttonpress
thetaf = atan2(angleLine2.YData(2)-angleLine2.YData(1),angleLine2.XData(2)-angleLine2.XData(1));
end

function calculateAngle(fig,~,h,angleLine,angleArc,x0,y0)
    point = h.CurrentPoint;
    X = point(1,1);
    Y = point(1,2);
    %r = sqrt((X-x0)^2 + (Y-y0)^2);
    r = 2;
    theta = atan2(Y-y0, X-x0);
    X = r*cos(theta) + x0;
    Y = r*sin(theta) + y0;
    angleLine.XData = [x0,X];
    angleLine.YData = [y0,Y];
    angleLine.Visible = 'on';
    %---------------------------------------
    angle = linspace(0,theta,100)';
    r = 1;
    angleArc.XData = r.*cos(angle) + ones(100,1).*x0;
    angleArc.YData = r.*sin(angle) + ones(100,1).*y0;
    angleArc.Visible = 'on';
end

function stopMouseTracking(fig,~)
    fig.WindowButtonMotionFcn = char.empty;
end