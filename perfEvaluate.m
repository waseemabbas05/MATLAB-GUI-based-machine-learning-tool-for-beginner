function [Xa,Ya,ColNames,RowNames,dataP] = perfEvaluate(Yact,Ypre,plotHandle)
%%
Actual=ones(size(Yact,1),1);
for i=1:size(Yact,2)
    Ind=find(Yact(:,i)==1);
    Actual(Ind,1)=i;
end
Ua=unique(Actual);
Up=unique(Ypre);
TC=length(Ua);
TempA=ones(size(Actual));
TempP=ones(size(Actual));
axes(plotHandle)
cla
PerfCheck=0;
%%
colors=[{'red'},{'green'},{'blue'},{'black'},{'cyan'}];
Xa=[];
Ya=[];
for i=1:TC
    TempA=ones(size(Actual));
    TempP=ones(size(Actual));
    TempA(find(Actual~=Ua(i)))=2;
    TempP(find(Ypre~=Ua(i)))=2;
    if length(unique(TempP))==length(unique(TempA))
        [X,Y] = perfcurve(TempA,TempP,2);
        Xa(:,i)=X;
        Ya(:,i)=Y;
        if length(X)~=0&length(Y)~=0
            if i<=5
                plot(X,Y,'linewidth',3,'color',cell2mat(colors(i)))
            else
                plot(X,Y,':','linewidth',3,'color',cell2mat(colors(i-5)))
            end
            hold on
            PerfCheck=PerfCheck+1;
        else
            WrongClasses=[WrongClasses i];
        end
    end
end
%%
if PerfCheck>0
    legend('Class 1','Class 2','Class 3','Class 4','Class 5','Class 6','Class 7','Class 8','Class 9','Class 10')
    set(gca,'fontsize',12)
    xlabel('False Positive')
    ylabel('True Positive')
    if PerfCheck~=length(Up)
        msgbox('Some Classes are missing')
    end
else
    msgbox('Performance curve cannot be plotted, there is only one class in predicted data')
end


ColNames=[];
RowNames=[];
for i=1:TC
    ColNames=[ColNames {['Class' num2str(i)]}];
    RowNames=[RowNames;{['Class' num2str(i)]}];
end


for i=1:TC
    Acti=find(Actual==Ua(i));
    TempActi=ones(length(Actual),1);
    TempActi(Acti)=-1;
    for j=1:TC
        TempPredj=zeros(length(Ypre),1);
        Predj=find(Ypre==Ua(j));
        TempPredj(Predj)=-1;
        dataP(i,j)=100*length(find(TempActi==TempPredj))/length(Acti);
    end
end