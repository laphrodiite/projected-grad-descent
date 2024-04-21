clc, clearvars, close all

% Initialising function f.
sympref('FloatingPointOutput',true);
syms x1 x2
f = (x1^2) * 1/3 + (x2^2) * 3;


% Calculation needed functions
v= [x1 x2];
fGrad = gradient(f, v);
fHess = hessian(f, v);

% Plotting to get a clear image.
if 1 == 0
figure(1);
ezsurf(f);
figure(2);
ezcontour(f);
end

grad = matlabFunction(fGrad);
numF = matlabFunction(f);

steepDes(f, fGrad, 2, -3, 5)
sDesProjection(numF, grad, -5, 10, 0.1, 15)

