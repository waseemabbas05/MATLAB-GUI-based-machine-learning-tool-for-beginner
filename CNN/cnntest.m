function [Er, Bad,Predicted,Actual,Precision,Recall,Accuracy,F1] = cnntest(cnn, Test_X, Test_Y)
%CNNTEST Evaluates a trained CNN over the provided test set.
%
%  Parameters
%    x  - Matrix of test images, with dimensions
%         imgHeight x imgWidth x numImages
%    y  - Correct labels, represented as a binary matrix with 1 row per
%         category and one column per example.
%
%  Returns
%    er - Percentage (0 - 1) of test samples which were misclassified.
%    bad - Indeces of misclassified test samples.

% Evaluate the CNN over the test samples.
[cnn, Out]= cnnff(cnn, Test_X);

% For each example, assign the category with the maximum output score.
[~, Predicted] = max(Out);

% Convert the test labels from binary vectors into integers.
[~, Actual] = max(Test_Y);

% Find the indeces of all of the incorrectly classified examples.
Bad = find(Predicted ~= Actual);

% Divide the number of incorrect classifications by the number of
% test examples to calculate the error.
Er = numel(Bad) / size(Test_Y, 2);


%%
NumClasses=length(unique(Actual));
%%
if nargin<3
    Precision=NaN;
    Recall=NaN;
    Accuracy=NaN;
    F1=NaN;
else
    %%
    if NumClasses==2
        U=unique(Actual);
        Tp= sum( (Actual==U(1)) & (Predicted==U(1)) );
        Fn= sum( (Actual==U(1)) & (Predicted~=U(1)) );
        Fp= sum( (Actual~=U(1)) & (Predicted==U(1)) );
        Tn= sum( (Actual~=U(1)) & (Predicted~=U(1)) );
        Precision=abs(100*Tp/(Tp+Fp));
        Recall=abs(100*Tp/(Tp+Fn));
        E=Actual-Predicted;
        Accuracy=length(find(E==0))/length(Predicted);
        Accuracy=100*Accuracy;
        F1=2*Precision*Recall/(Precision+Recall);
    else
        Tp=0;Fp=0;Tn=0;Fn=0;
        U=unique(Actual);
        for i=1:NumClasses
            Tp= Tp+sum( (Actual==U(i)) & (Predicted==U(i)) );
            Fn= Fn+sum( (Actual==U(i)) & (Predicted~=U(i)) );
            Fp= Fp+sum( (Actual~=U(i)) & (Predicted==U(i)) );
            Tn= Tn+sum( (Actual~=U(i)) & (Predicted~=U(i)) );
        end
        Precision=abs(100*Tp/(Tp+Fp));
        Recall=abs(100*Tp/(Tp+Fn));
        E=Actual-Predicted;
        Accuracy=length(find(E==0))/length(Predicted);
        Accuracy=100*Accuracy;
        F1=2*Precision*Recall/(Precision+Recall);
    end  
end
