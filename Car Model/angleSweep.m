function [] = angleSweep(x0,xf,y0,yf,T)

time = 0:.0001:T;
time = time';


%DEFINE REFERENCE VELOCITY FOR GIVEN TIMES
for i = 0:pi/360:2*pi
    theta0 = -i;
    thetaf = i;

    s0 = 1; sf = 1;
    xInputMatrix = [0         0       0      0     0    1;
                    0         0       0      0     1    0;
                    0         0       0      2     0    0;
                    T^5      T^4     T^3    T^2    T    1;
                    5*T^4   4*T^3   3*T^2   2*T    1    0;
                    20*T^3 12*T^2   6*T      2     0    0];
    xInputVect = [x0;0;cos(theta0)*s0;xf;0;cos(thetaf + pi)*sf];
    xPos = xInputMatrix\xInputVect;
    xList = polyval(xPos,time(:,1));
    
    yInputVect = [y0;0;sin(theta0)*s0;yf;0;sin(thetaf + pi)*sf];
    yPos = xInputMatrix\yInputVect;
    yList = polyval(yPos,time(:,1));
    
    figure(1)
    plot(xList,yList,'b','LineWidth',2)
    h=gca;h.LineWidth=2;h.FontSize=18;h.DataAspectRatio=[1,1,1];
    xlim([-1 11])
    ylim([-1 6])
    pause(.1)
end