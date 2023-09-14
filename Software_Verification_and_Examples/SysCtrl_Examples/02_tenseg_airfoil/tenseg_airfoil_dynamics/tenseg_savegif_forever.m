function tenseg_savegif_forever(varargin)
%% tenseg_savegif_forever
% This function will save the animation in the for loop as gif file.
% How to use it?
% 1. When use it, it has to be in for loop, the default name is ‘untitledgif.gif?;
% 2. savegif('filename') will named the animation as ‘filename.gif?.
% 3. savegif('filename.gif') will named the animation as ‘filename.gif?.
% Note: please use 'clear all' to clean all the global variables when using this function. 
%%
% warning off;
loops=65535;
global iiii;
global time;
p=clock;
if isempty(varargin)
	filename='untitledgif.gif';
else
	filename=varargin{1};
	if length(filename)<4
        filename=[filename,'.gif'];
    else
        if ~strcmp(filename(end-3:end),'.gif')
            filename=[filename,'.gif'];
        end
	end
end
if isempty(iiii)
	iiii=0;
	time=p(6);
else
	iiii=iiii+1;
	if ((p(6)>=time)*(p(6)-time)+(p(6)<time)*(p(6)+60-time))>10
        iiii=0;
    end
	time=p(6);
end
f=getframe(gcf);
f=frame2im(f);
[f,map]=rgb2ind(f,256);
if iiii==0
	imwrite(f,map,filename,'LoopCount',loops,'delaytime',.1);
else
	imwrite(f,map,filename,'writemode','append','delaytime',.1);
end