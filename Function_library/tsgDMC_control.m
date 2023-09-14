function u = tsgDMC_control(K,y_est,r)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% u = tsgDMC_control(K,r,y_bar) computes the Markov data-based optimal
% input control sequence (control increment sequence for reference tracking
% applications) for interval [k,N] using the information of reference 
% trajectory of interval [k,N] (r) and Markov data-based output estimate 
% for interval [k,N] (y_bar)
%
% Inputs:
%	K: optimal controller gain
%	y_est: MaD output estimate for the desired horizon
%   r (optional): reference trajectory for the desired horizon
%
% Outputs:
%   u: input control sequence (control increment sequence for reference
%   tracking applications)
%%
switch nargin
    case 2
        u = K*(-y_est);
    case 3
        r = reshape(r,numel(r),1);
        u = K*(r-y_est);
end
end


