function [endVector] = sDesProjection(numF, grad, x1Start, x2Start, step, sk)

% Initializing elements
k = 1;
vNew(1) = x1Start;
vNew(2) = x2Start;
gradHere = grad(vNew(1), vNew(2));

% Initializing matrices to hold history
kMatx = 0;
x1Matx = 0;
x2Matx = 0;
X1area = linspace(-10, 5);
X2area = linspace(-8, 12);

while (norm(gradHere)>0.01 && k<150)
    
    vOld = vNew;
    gradHere = grad(vOld(1), vOld(2))
    
    % Projection and calculation of new values
    dk(1) = projection(vOld(1) - gradHere(1), X1area) - vOld(1)
    dk(2) = projection(vOld(2) - gradHere(2), X2area) - vOld(2)
    vNew = vOld + step * dk
    
    % Feature to spot oscillation
    if numF(vNew(1), vNew(2)) > numF(vOld(1), vOld(2))
        disp("Error: Condition not met.")
       %break;
    end

    % Storing new values
    xMatx(k) = vNew(1);
    yMatx(k) = vNew(2);
    kMatx(k) = k;
    k = k + 1
end
endVector = vNew;
disp(numF(endVector(1), endVector(2)))

% Plotting configuration
    figure(3);
    plot(kMatx, xMatx)
    grid on
    xlabel('k');
    ylabel('x1k')
    title('Convergence of x1 for data Θ3')
    xlim([0 k])
    figure(4);
    plot(kMatx, yMatx)
    grid on
    xlim([0 k])
    xlabel('k');
    ylabel('x2k')
    title('Convergence of x2 for data Θ3')


end

function [res] = projection(x, area)
% Function that calculates the projection of variable x onto an area.
  [M, I] = min(abs(area - x).^2);
  res = area(I);
end