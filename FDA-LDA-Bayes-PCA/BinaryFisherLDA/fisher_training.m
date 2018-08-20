% This multi-class fisher classifier is based on binary fisher classifer developed by Quan Wang <wangq10@rpi.edu>
% Signal Analysis and Machine Perception Laboratory
% Department of Electrical, Computer, and Systems Engineering
% Rensselaer Polytechnic Institute, Troy, NY 12180, USA
%% The training of  Fisher's linear discriminant
% Inputs
%    Train_X: N*p feature matrix, each row being a data point (N rows and p features)
%    Train_Y: N*M (binary coding for each row) or N*1 (actual class number as label) label vector
% Outputs
%   fisher : Trained fisher pbject. A fisher object contains weights for
%   optimal one dimensional hyper plane and the separating threshold

function fisher=fisher_training(Train_X,Train_Y)

%%
Train_X=Train_X+.0001;
NumClass=size(Train_Y,2);
if size(Train_Y,2)==1
    NumClass=length(unique(Train_Y));
    Tr=zeros(length(Train_Y),NumClass);
    U=unique(Train_Y);
    for i=1:NumClass
        Tr(find(Train_Y==U(i)),i)=1;
    end
    Train_Y=Tr;
end
%%

if NumClass>2
    fisher.W=[];
    fisher.Thresh=[];
    fisher.Fp=[];
else
    fisher.W=[];
    fisher.Thresh=[];
    fisher.Fp=[];
end
%% check input
if size(Train_Y,1)~=size(Train_X,1)
    fprintf(['Incorrect input: f must be n*m, l must be n*1, '...
        'and l can only contain value 0 or 1.\n']);
    W=NaN;
    Thresh=NaN;
    Fp=NaN;
    return;
end

%% get projection weights
if NumClass>2
    for i=1:NumClass
        Train_Y_Temp=Train_Y(:,i);
        f0=Train_X(Train_Y_Temp==0,:);
        f1=Train_X(Train_Y_Temp==1,:);
        
        mu0=mean(f0);
        mu1=mean(f1);
        S0=cov(f0);
        S1=cov(f1);
        Mu=mu1-mu0;
        Mu=Mu+.0001;
%         W=(S0+S1)\(Mu)';
        W=((S0+S1))*pinv(Mu);
        
        %%
        fisher.W{i}={W};
        Fp=Train_X*W;
        fisher.Fp{i}={Fp};
        %% get threshold
        f0=Fp(Train_Y_Temp==0,:);
        f1=Fp(Train_Y_Temp==1,:);
        
        n0=size(f0,1);
        n1=size(f1,1);
        
        mu0=nanmean(f0);
        mu1=nanmean(f1);
        S0=cov(f0);
        S1=cov(f1);
        
        a=S1-S0;
        b=-2*(mu0*S1-mu1*S0);
        c=S1*mu0^2-S0*mu1^2-2*S0*S1*log(n0/n1);
        
        if b^2-4*a*c<0
            fprintf('No threshold found. \n');
            Thresh=NaN;
            fisher=NaN;
            return;
        else
            d=sqrt(b^2-4*a*c);
            t1=(-b+d)/2/a;
            t2=(-b-d)/2/a;
            
            if (t1-mu0)^2<(t2-mu0)^2
                Thresh=t1;
            else
                Thresh=t2;
            end
            fisher.Thresh(i)=Thresh;
        end
    end
else
    Train_Y=Train_Y(:,1);
    f0=Train_X(Train_Y==0,:);
    f1=Train_X(Train_Y==1,:);
    
    mu0=mean(f0);
    mu1=mean(f1);
    S0=cov(f0);
    S1=cov(f1);
    
    Mu=mu1-mu0;
    Mu=Mu+.0001;
    %         W=(S0+S1)\(Mu)';
    W=((S0+S1))*pinv(Mu);
    fisher.W=W;
    
    Fp=Train_X*W;
    fisher.Fp=Fp;
    %% get threshold
    f0=Fp(Train_Y==0,:);
    f1=Fp(Train_Y==1,:);
    
    n0=size(f0,1);
    n1=size(f1,1);
    
    mu0=mean(f0);
    mu1=mean(f1);
    S0=cov(f0);
    S1=cov(f1);
    
    a=S1-S0;
    b=-2*(mu0*S1-mu1*S0);
    c=S1*mu0^2-S0*mu1^2-2*S0*S1*log(n0/n1);
    
    if b^2-4*a*c<0
        fprintf('No threshold found. \n');
        Thresh=NaN;
        fisher=NaN;
        return;
    else
        d=sqrt(b^2-4*a*c);
        t1=(-b+d)/2/a;
        t2=(-b-d)/2/a;
        
        if (t1-mu0)^2<(t2-mu0)^2
            Thresh=t1;
        else
            Thresh=t2;
        end
        fisher.Thresh=Thresh;
    end
end