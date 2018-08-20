function Y=scaledResize(X,NLayers,SubSamplingScale,KernelSize,E)
%%
KernelSize=5;
SubSamplingScale=3;
E=4;
NLayers=2;
TempD=E;
for i=1:NLayers
    TempD=TempD*SubSamplingScale;
    TempD=TempD+KernelSize-1;
end
Y=imresize(X,[TempD,TempD]);