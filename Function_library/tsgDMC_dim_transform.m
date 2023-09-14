function Hi = tsgDMC_dim_transform(H)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% Hi = tsgDMC_dim_transform(H) transforms the parameter sequence from 3D 
% arrays to 2D arrays.
%
% Inputs:
%	H: 3D input Markov parameters
%
% Outputs:
%	Hi: 2D input Markov parameters
%%
m = size(H,1);
r = size(H,2);

for i = 1:size(H,3)
    Hi((i-1)*m+1:i*m,1:r) = H(:,:,i);
end
end
