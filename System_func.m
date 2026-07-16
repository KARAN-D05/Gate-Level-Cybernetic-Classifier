function out = func(inputs, threshold)
    % inputs: vector of binary values (e.g., [0 1 1 0 ...])
    % threshold: integer threshold
    sum_val = sum(inputs);
    fprintf('Sum => %d\n', sum_val);
    fprintf('Threshold => %d\n', threshold);
    if sum_val > threshold
        out = 1;
    else
        out = 0;
    end
end

disp('System Activation Function: R(M, θ) = 1 if M > θ, else 0')

% input vectors
inputs = [1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0];

fprintf('System Output => %d\n', func(inputs, 7));
