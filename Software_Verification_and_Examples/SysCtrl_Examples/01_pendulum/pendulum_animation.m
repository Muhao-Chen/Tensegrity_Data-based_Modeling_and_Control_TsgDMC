function h = pendulum_animation(N,L,y,i)
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/.
%
% h = pendulum_animation(N,L,y,i) generates the gif animation of the 
% control process for the simple pendulum.
%
% Inputs:
%   N: horizon
%   L: pendulum bar length
%	y: output trajectory
%   i: case number
%
% Outputs:
%   h: gif object


%% Initialization
O = [0 0];
h = figure;
if i == 1
    temp = '_small_input';
elseif i == 2
    temp = '_medium_input';
else
    temp = '_large_input';
end
filename = ['simple_pendulum' temp '.gif'];
axis([-1.3*L 1.3*L -1.3*L 1.3*L]);
grid on;
ylabel('Y-Coordinate (m)','Interpreter','latex')
xlabel('X-Coordinate (m)','Interpreter','latex')

%% Perform Animation
for i = 1:N+1
    P = L*[sin(y(i)) -cos(y(i))];
    O_circ = viscircles(O,0.01);
    pend = line([O(1) P(1)], [O(2) P(2)]);
    ball = viscircles(P,0.05);
    pause(0.001);

    frame = getframe(h);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    % Write to the GIF File
    if i == 1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.01);
    end

    if i<N+1
        delete(pend);
        delete(ball);
        delete(O_circ);
    end
end
end

