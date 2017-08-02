function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%

% Unfold the U and W matrices from params
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);

            
% Initialize reture value
J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));



reg_theta = Theta(:);
reg_X = X(:);
J = 0.5*sum(sum(((X * Theta' - Y).^2).*R)) + 0.5*lambda*sum(reg_theta.^2)+0.5*lambda*sum(reg_X.^2);
X_grad = ((X * Theta' - Y).*R)*Theta + lambda*X;
Theta_grad =((Theta * X' - Y').*(R'))*X + lambda*Theta;














% =============================================================

grad = [X_grad(:); Theta_grad(:)];

end
