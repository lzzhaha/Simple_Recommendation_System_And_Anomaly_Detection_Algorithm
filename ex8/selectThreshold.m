function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%

bestEpsilon = 0;
bestF1 = 0;
F1 = 0;

stepsize = (max(pval) - min(pval)) / 1000;
for epsilon = min(pval):stepsize:max(pval)
 
  
temp_pval = pval;
temp_pval = temp_pval<epsilon;
num_pred_pos = sum(temp_pval);
comp = temp_pval == yval;
tp = comp' * yval;
num_real_pos = sum(yval);

%calculate the precision
if num_pred_pos !=0
  prec = tp/(num_pred_pos);
else
  prec = 0;
endif
%calculate the recall
if num_real_pos !=0
  rec = tp/(num_real_pos);
else 
  rec = 0;
endif
%calculate the F1 score
if prec+rec == 0
  F1 =0
else
  F1 = 2*(prec*rec)/(prec+rec);
endif





    % =============================================================

    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end

end
