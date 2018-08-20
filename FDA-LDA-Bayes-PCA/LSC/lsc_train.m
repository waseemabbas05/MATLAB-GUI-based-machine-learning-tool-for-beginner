function [lsc] = lsc_train(Train_X,Train_Y,tol2)
% PLS   Partial Least Squares Regrassion
%
% [T,P,U,Q,B,Q] = pls(X,Y,tol) performs particial least squares regrassion
% between the independent variables, X and dependent Y as
% X = T*P' + E;
% Y = U*Q' + F = T*B*Q' + F1;
%
% Inputs:
% X     data matrix of independent variables
% Y     data matrix of dependent variables
% tol   the tolerant of convergence (defaut 1e-10)
%
% Outputs:
% T     score matrix of X
% P     loading matrix of X
% U     score matrix of Y
% Q     loading matrix of Y
% B     matrix of regression coefficient
% W     weight matrix of X
%
% Using the PLS model, for new X1, Y1 can be predicted as
% Y1 = (X1*P)*B*Q' = X1*(P*B*Q')
% or
% Y1 = X1*(W*inv(P'*W)*inv(T'*T)*T'*Y)
%
% Without Y provided, the function will return the principal components as
% X = T*P' + E
%
% Example: taken from Geladi, P. and Kowalski, B.R., "An example of 2-block
% predictive partial least-squares regression with simulated data",
% Analytica Chemica Acta, 185(1996) 19--32.
%{
x=[4 9 6 7 7 8 3 2;6 15 10 15 17 22 9 4;8 21 14 23 27 36 15 6;
10 21 14 13 11 10 3 4; 12 27 18 21 21 24 9 6; 14 33 22 29 31 38 15 8;
16 33 22 19 15 12 3 6; 18 39 26 27 25 26 9 8;20 45 30 35 35 40 15 10];
y=[1 1;3 1;5 1;1 3;3 3;5 3;1 5;3 5;5 5];
% leave the last sample for test
N=size(x,1);
x1=x(1:N-1,:);
y1=y(1:N-1,:);
x2=x(N,:);
y2=y(N,:);
% normalization
xmean=mean(x1);
xstd=std(x1);
ymean=mean(y1);
ystd=std(y);
X=(x1-xmean(ones(N-1,1),:))./xstd(ones(N-1,1),:);
Y=(y1-ymean(ones(N-1,1),:))./ystd(ones(N-1,1),:);
% PLS model
[T,P,U,Q,B,W]=pls(X,Y);
% Prediction and error
yp = (x2-xmean)./xstd * (P*B*Q');
fprintf('Prediction error: %g\n',norm(yp-(y2-ymean)./ystd));
%}
%
% By Yi Cao at Cranfield University on 2nd Febuary 2008
%
% Reference:
% Geladi, P and Kowalski, B.R., "Partial Least-Squares Regression: A
% Tutorial", Analytica Chimica Acta, 185 (1986) 1--7.
%

% Input check

if nargin<2
    Train_Y=Train_X;
end
tol = 1e-10;
if nargin<3
    tol2=1e-10;
end
%%
if size(Train_Y,2)==1
    Uy=unique(Train_Y);
    NumClasses=length(Uy);
    if NumClasses>2
        Ya=zeros(length(Train_Y),NumClasses);
        for i=1:NumClasses
            Ya(find(Train_Y==Uy(i)),i)=1;
        end
    else
        Ya=Train_Y;
    end
elseif size(Train_Y,2)==2
    Ya=Train_Y(:,1);
    NumClasses=size(Train_Y,2);
else
    NumClasses=size(Train_Y,2);
    Ya=Train_Y;
end
clear Uy i
clear Y

%%
for i=1:size(Train_X,2)
    Ind=find(abs(Train_X(:,i))==Inf|isnan(Train_X(:,i))==1);
    if length(Ind)>0
        Ind
        IndT=1:size(Train_X,1);
        IndT(Ind)=[];
        Train_X(Ind,i)=mean(Train_X(IndT,i));
    end
end

%%
X=Train_X;Y=Train_Y;
if NumClasses==2
    %     Train_Y=Ya;
    % Size of x and y
    [rX,cX]  =  size(X);
    [rY,cY]  =  size(Y);
    assert(rX==rY,'Sizes of X and Y mismatch.');
    
    % Allocate memory to the maximum size
    n=size(X,2);
    T=zeros(rX,n);
    P=zeros(cX,n);
    U=zeros(rY,n);
    Q=zeros(cY,n);
    B=zeros(n,n);
    W=P;
    k=0;
    
    %%
    % iteration loop if residual is larger than specfied
    while norm(Y)>tol2 && k<n
        % choose the column of x has the largest square of sum as t.
        % choose the column of y has the largest square of sum as u.
        [dummy,tidx] =  max(sum(X.*X));
        [dummy,uidx] =  max(sum(Y.*Y));
        t1 = X(:,tidx);
        u = Y(:,uidx);
        t = zeros(rX,1);
        
        % iteration for outer modeling until convergence
        while norm(t1-t) > tol
            w = X'*u;
            w = w/norm(w);
            t = t1;
            t1 = X*w;
            q = Y'*t1;
            q = q/norm(q);
            u = Y*q;
        end
        % update p based on t
        t=t1;
        p=X'*t/(t'*t);
        pnorm=norm(p);
        p=p/pnorm;
        t=t*pnorm;
        w=w*pnorm;
        
        % regression and residuals
        b = u'*t/(t'*t);
        X = X - t*p';
        Y = Y - b*t*q';
        
        % save iteration results to outputs:
        k=k+1;
        T(:,k)=t;
        P(:,k)=p;
        U(:,k)=u;
        Q(:,k)=q;
        W(:,k)=w;
        B(k,k)=b;
        % uncomment the following line if you wish to see the convergence
        %     disp(norm(Y))
    end
    T(:,k+1:end)=[];
    P(:,k+1:end)=[];
    U(:,k+1:end)=[];
    Q(:,k+1:end)=[];
    W(:,k+1:end)=[];
    B=B(1:k,1:k);
    
    %%
    lsc.P=P;
    lsc.B=B;
    lsc.T=T;
    lsc.U=U;
    lsc.Q=Q;
    lsc.W=W;
else
    for i=1:NumClasses
        Train_Y=Ya(:,i);
        % Size of x and y
        [rX,cX]  =  size(Train_X);
        [rY,cY]  =  size(Train_Y);
        assert(rX==rY,'Sizes of X and Y mismatch.');
        
        % Allocate memory to the maximum size
        n=size(Train_X,2);
        T=zeros(rX,n);
        P=zeros(cX,n);
        U=zeros(rY,n);
        Q=zeros(cY,n);
        B=zeros(n,n);
        W=P;
        k=0;
        %%
        % iteration loop if residual is larger than specfied
        while norm(Train_Y)>tol2 && k<n
            % choose the column of x has the largest square of sum as t.
            % choose the column of y has the largest square of sum as u.
            [dummy,tidx] =  max(sum(Train_X.*Train_X));
            [dummy,uidx] =  max(sum(Train_Y.*Train_Y));
            t1 = Train_X(:,tidx);
            u = Train_Y(:,uidx);
            t = zeros(rX,1);
            J=0;
            % iteration for outer modeling until convergence
            while norm(t1-t) > tol||J==0
                w = Train_X'*u;
                w = w/norm(w);
                t = t1;
                t1 = Train_X*w;
                q = Train_Y'*t1;
                q = q/norm(q);
                u = Train_Y*q;
                J=J+1;
            end
            % update p based on t
            t=t1;
            p=Train_X'*t/(t'*t);
            pnorm=norm(p);
            p=p/pnorm;
            t=t*pnorm;
            w=w*pnorm;
            
            % regression and residuals
            b = u'*t/(t'*t);
            Train_X = Train_X - t*p';
            Train_Y = Train_Y - b*t*q';
            
            % save iteration results to outputs:
            k=k+1;
            display(['Class : ' num2str(i) ' ; Norm : ' num2str(norm(Train_Y)) ' ; Feature : ' num2str(k)])
            T(:,k)=t;
            P(:,k)=p;
            U(:,k)=u;
            Q(:,k)=q;
            W(:,k)=w;
            B(k,k)=b;
            % uncomment the following line if you wish to see the convergence
            %     disp(norm(Y))
        end
        %         T(:,k+1:end)=[];
        %         P(:,k+1:end)=[];
        %         U(:,k+1:end)=[];
        %         Q(:,k+1:end)=[];
        %         W(:,k+1:end)=[];
        B=B(1:k,1:k);
        
        %%
        lsc.P{i}={P};
        lsc.B{i}={B};
        lsc.T{i}={T};
        lsc.U{i}={U};
        lsc.Q{i}={Q};
        lsc.W{i}={W};
        display(['Class ' num2str(i) ' done'])
    end
end

