function [endVector] = steepDes(f, fGrad, xStart, yStart, step)

syms x y
k = 1;

numF = matlabFunction(f);
grad = matlabFunction(fGrad);

% Initializing elements
vNew(1) = xStart;
vNew(2) = yStart;
x = vNew(1);
y = vNew(2);
gradHere = grad(x, y);

% Initializing matrices to hold history
kMatx = 0;
xMatx = 0;
yMatx = 0;


while norm(gradHere)>0.001
    vOld = vNew;
    x = vOld(1);
    y = vOld(2);
    gradHere = grad(x, y);
    dk = (-1) * gradHere;
    
    % Calculation of new values
    vNew(1) = vOld(1) + step*dk(1);
    vNew(2) = vOld(2) + step*dk(2);
    
    % Feature to spot oscillation
    if numF(vNew(1), vNew(2)) > numF(vOld(1), vOld(2))
        disp("Error: Condition not met.")
      %  break;
    end

    % Storing new values
    xMatx(k) = vNew(1);
    yMatx(k) = vNew(2);
    kMatx(k) = k;
    k = k + 1;
end

endVector = vNew;
disp(numF(endVector(1), endVector(2)))
disp(k)

% Plotting configuration
    figure(3);
    plot(kMatx, xMatx)
    grid on
    xlabel('k');
    ylabel('x1k')
    title('Convergence of x1 for step 5')
    xlim([0 k])
    figure(4);
    plot(kMatx, yMatx)
    grid on
    xlim([0 k])
    xlabel('k');
    ylabel('x2k')
    title('Convergence of x2 for step 5')

end