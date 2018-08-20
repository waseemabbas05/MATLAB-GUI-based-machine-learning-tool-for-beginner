% Apply Naive Bayesian Classifier on input data to produce labels
% This function is called inside naive_bayes_test.m. It produces labels on
% input data which are then compared to true labels along, also confirmed
% by their posterior probabilities
% Inputs
%           naivebayes : Trained Naive Bayesian Classifier
%           X          : Input Data
% Outputs
%           Predicted_Classes : Class labels produced by naive bayes
%           Posteriors        : Posterior probabilities of classes

function [Predicted_Classes, Posteriors] = naive_bayes_classify(naivebayes,X)

Evidence=naivebayes.Evidence;
Likelihoods=naivebayes.Likelihood_Matrix;
Priors=naivebayes.Priors;
N_Classes = size(Priors, 1);
N_Vectors = size(X, 1);
Predicted_Classes = zeros(N_Vectors, 1);
Posteriors = zeros(N_Vectors, N_Classes);

for i=1:N_Vectors
    
    Vector = find(X(i, :)' == 1);
    Likelihood_Frame = Likelihoods(:, Vector);
    Post = prod(Likelihood_Frame,2) .* Priors ./ prod(Evidence(Vector),1);
    [Max_Val, Class] = max(Post);
    Predicted_Classes(i) = Class;
    Posteriors(i,:) = Post';
    
end

end
