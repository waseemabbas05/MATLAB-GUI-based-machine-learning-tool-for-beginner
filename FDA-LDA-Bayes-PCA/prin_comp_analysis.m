function [MappedX, XMap] = prin_comp_analysis(X, NDims)
% This function Perform the PCA algorithm
% Input arguments
% X: Features matrix on which we want to run PCA for dimensionality reduction
% NDims: Target dimensions for the reduced dimensionality matrix. Let’s say original dimensions of the input feature 
% matrix X are N × M. For dimensionality reduction, NDims < M
%
% Output Arguments
% MappedX: Output feature vector with reduced dimensions
% XMap: A structure which contains information about mapping of original feature matrix onto mapped features matrix. 
% It has following fields
% mean: Means of retained principal components
% M: Mapping matrix of principal components. It can be used to reduce dimensions of input feature vector. Let’s input
% feature vector dimensions are N × M1  and our target dimension is N× M_2  such that M2 < M1. Dimension of M in this
% case is M1× M2. We can reduce dimensions of input matrix A by projecting it along M as follows
%
% Example
% X= rand(1000,50);
% [MappedX, XMap] = prin_comp_analysis(X, 20);
%
% This function is based on algorithm developed by Laurens van der Maaten,
% Maastricht University, 2007

    if ~exist('NDims', 'var')
        NDims = 2;
    end
	
	% Make sure data is zero mean
    XMap.mean = mean(X, 1);
	X = X - repmat(XMap.mean, [size(X, 1) 1]);

	% Compute covariance matrix
    if size(X, 2) < size(X, 1)
        C = cov(X);
    else
        C = (1 / size(X, 1)) * (X * X');        % if N>D, we better use this matrix for the eigendecomposition
    end
	
	% Perform eigendecomposition of C
	C(isnan(C)) = 0;
	C(isinf(C)) = 0;
    [M, lambda] = eig(C);
    
    % Sort eigenvectors in descending order
    [lambda, ind] = sort(diag(lambda), 'descend');
    if NDims > size(M, 2)
        NDims = size(M, 2);
        warning(['Target dimensionality reduced to ' num2str(NDims) '.']);
    end
	M = M(:,ind(1:NDims));
    lambda = lambda(1:NDims);
	
	% Apply mapping on the data
    if ~(size(X, 2) < size(X, 1))
        M = (X' * M) .* repmat((1 ./ sqrt(size(X, 1) .* lambda))', [size(X, 2) 1]);     % normalize in order to get eigenvectors of covariance matrix
    end
    MappedX = X * M;
    
    % Store information for out-of-sample extension
    XMap.M = M;
	XMap.lambda = lambda;
    