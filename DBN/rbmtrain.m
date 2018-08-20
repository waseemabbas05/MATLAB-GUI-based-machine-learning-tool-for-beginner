function rbm = rbmtrain(rbm, X,opts, Ind,N)
assert(isfloat(X), 'x must be a float');
%     assert(min(min(x))==0 && max(max(x))==1, 'all data in x must be in [0:1]');
%%
m = size(X, 1);

NumBatches = m / opts.batchsize;

assert(rem(NumBatches, 1) == 0, 'numbatches not integer');

%%
check=1;
h = waitbar(0,'Training...');
MaxIterations=opts.numepochs*NumBatches;
k=1;


for i = 1 : opts.numepochs
    %%
    RandIndices = randperm(m);
    err = 0;
    for l = 1 : NumBatches
        %%
        StartIndexOfBatch=(l - 1) * opts.batchsize + 1;
        EndIndexOfBatch=l * opts.batchsize;
        Batch = X(RandIndices(StartIndexOfBatch:EndIndexOfBatch), :);
        
        v1 = Batch;
        TempV1=repmat(rbm.c', opts.batchsize, 1) + v1 * rbm.W';
        
        h1 = double(1./(1+exp(-TempV1)) > rand(size(TempV1)));
        TempH1=repmat(rbm.b', opts.batchsize, 1) + h1 * rbm.W;
        
        v2=double(1./(1+exp(-TempH1)) > rand(size(TempH1)));
        
        TempV2=repmat(rbm.c', opts.batchsize, 1) + v2 * rbm.W';
        h2 = 1./(1+exp(-TempV2));
        
        c1 = h1' * v1;
        c2 = h2' * v2;
        
        rbm.vW = rbm.momentum * rbm.vW + rbm.alpha * (c1 - c2)     / opts.batchsize;
        rbm.vb = rbm.momentum * rbm.vb + rbm.alpha * sum(v1 - v2)' / opts.batchsize;
        rbm.vc = rbm.momentum * rbm.vc + rbm.alpha * sum(h1 - h2)' / opts.batchsize;
        
        rbm.W = rbm.W + rbm.vW;
        rbm.b = rbm.b + rbm.vb;
        rbm.c = rbm.c + rbm.vc;
        
        err = err + nansum(nansum((v1 - v2) .^ 2)) / opts.batchsize;
        if check==1
            k=(NumBatches)*(i-1)+l;
            waitbar(k/MaxIterations,h,sprintf('%s',[num2str(100*(k-1)/MaxIterations) ' % training done for RBM ' num2str(Ind) '/' num2str(N)]))
        end
    end
    
    disp(['epoch ' num2str(i) '/' num2str(opts.numepochs)  '. Average reconstruction error is: ' num2str(err / NumBatches)]);

    
end

close(h)


