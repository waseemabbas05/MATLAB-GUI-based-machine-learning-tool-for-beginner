function [models] = multisvmtrain(Train_X,Train_Y,options)
if isreal(Train_X)==0
    Train_X=abs(Train_X);
end
if size(Train_Y,2)>1
    for i=1:size(Train_Y,1)
        [jnk Y1(i,1)]=max(Train_Y(i,:));
    end  
    Train_Y=Y1;   
    clear Y1 Y2;
end
U=unique(Train_Y);
numClasses=length(U);

%%
%build models
StopCrit=options.StopCrit;
KCLimit=1000;
if numClasses>2
    for k=1:numClasses
        %Vectorized statement that binarizes Group
        %where 1 is the current class and 0 is all other classes
        G1vAll=(Train_Y==U(k));
        if strcmp(options.KernelFunction,'polynomial')==1
            models(k) = svmtrain(Train_X,G1vAll,'options',options,'Tol',StopCrit,'polyorder',options.PolynomialOrder,'method',options.Method,'kernelcachelimit',KCLimit);
        elseif strcmp(options.KernelFunction,'rbf')==1
            models(k) = svmtrain(Train_X,G1vAll,'options',options,'Tol',StopCrit,'rbf_sigma',options.RBF_Sigma,'method',options.Method,'kernelcachelimit',KCLimit);
        else
            models(k) = svmtrain(Train_X,G1vAll,'options',options,'Tol',StopCrit,'method',options.Method,'kernelcachelimit',KCLimit);
        end
    end
else
    G1vG2=(Train_Y==U(1));
    if strcmp(options.KernelFunction,'polynomial')==1
        models = svmtrain(Train_X,G1vG2,'options',options,'Tol',StopCrit,'polyorder',options.PolynomialOrder,'method',options.Method,'kernelcachelimit',KCLimit);
    elseif strcmp(options.KernelFunction,'rbf')==1
        models = svmtrain(Train_X,G1vG2,'options',options,'Tol',StopCrit,'rbf_sigma',options.RBF_Sigma,'method',options.Method,'kernelcachelimit',KCLimit);
    else
        models = svmtrain(Train_X,G1vG2,'options',options,'Tol',StopCrit,'method',options.Method,'kernelcachelimit',KCLimit);
    end
end

