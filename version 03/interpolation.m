

coefficients = table2array(readtable('coefficients.csv'));


alfa1_i = {
    get_param_tl(coefficients(:,1)), get_param_tl(coefficients(:,2)), ...
    get_param_tl(coefficients(:,3)), get_param_tl(coefficients(:,4))
};

alfa2_i = {
    get_param_tl(coefficients(:,5)), get_param_tl(coefficients(:,6)), ...
    get_param_tl(coefficients(:,7)), get_param_tl(coefficients(:,8))
};

beta1_i = {
    get_param_tl(coefficients(:,9)), get_param_tl(coefficients(:,10)), ...
    get_param_tl(coefficients(:,11)), get_param_tl(coefficients(:,12))
};

beta2_i = {
    get_param_tl(coefficients(:,13)), get_param_tl(coefficients(:,14)), ...
    get_param_tl(coefficients(:,15)), get_param_tl(coefficients(:,16))
};

k_settle_i = {
    get_param_tl(coefficients(:,17)), get_param_tl(coefficients(:,18)), ...
    get_param_tl(coefficients(:,19)), get_param_tl(coefficients(:,20))
};

k_counter_i = {
    get_param_tl(coefficients(:,21)), get_param_tl(coefficients(:,22)), ...
    get_param_tl(coefficients(:,23)), get_param_tl(coefficients(:,24))
};


function tl = get_param_tl(param)
    TEMPERATURES  = [ 1100.0, 1150.0, 1200.0 ];
    SETTLE_TIMES  = [ 1.52, 1.92, 2.32, 2.72, 3.12 ];
    COOLING_TIMES = [ 3.60, 4.00, 4.48, 4.88, 5.36  ];
    tmp = zeros(length(TEMPERATURES), ...
                length(SETTLE_TIMES), ...
                length(COOLING_TIMES));
    for i = 1:length(TEMPERATURES)
        for j = 1:length(SETTLE_TIMES)
            for k = 1:length(COOLING_TIMES)
                idx = (i - 1) * 25 + (5 - (j - 1) - 1) * 5 + 5 - (k - 1);
                tmp(i, j, k) = param(idx);
            end
        end
    end
    tl = griddedInterpolant({ TEMPERATURES, SETTLE_TIMES, COOLING_TIMES }, ...
                            tmp, 'linear');
end
