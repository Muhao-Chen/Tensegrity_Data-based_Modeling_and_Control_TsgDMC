%% ^_^ Welcome to Tensegrity Data-based Modeling and Control (TsgDMC) software! ^_^ %%
% SETUP file to be run only the first time
%
% /* This Source Code Form is subject to the terms of the Mozilla Public
% * License, v. 2.0. If a copy of the MPL was not distributed with this
% * file, You can obtain one at http://mozilla.org/MPL/2.0/. 
%% Add all necessary functions to MATLAB path 
% set up the workspace
clear; clc;
originFolder=fileparts(mfilename('fullpath')); %Main folder

% add the function libraries
addpath(fullfile(originFolder,'Function_library'));

% add the Software Verification and Examples (with sub-folders)
addpath(genpath(fullfile(originFolder,'Software_Verification_and_Examples')));

% add User Guide
addpath(genpath('User_Guide'));

% add Joss Paper folder
addpath(genpath('JOSS_paper'));

% add Videos folder
addpath(genpath('Videos'));
%% Save path definitions
savepath; 

%% Welcome
disp('Welcome to Tensegrity Data-based Modeling and Control (TsgDMC) software!');