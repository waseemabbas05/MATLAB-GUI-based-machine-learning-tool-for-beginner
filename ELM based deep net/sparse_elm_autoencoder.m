function W = sparse_elm_autoencoder(A,B,Lam,Itrs)
% The auto-encoder is based on "Building feature space of extreme learning
% machine with sparse denoising stacked-autoencoder" by Le-Le Cao et al,
% NeuroComputing p-60-71
% Tang et al, "Extreme Learning Machine for Multilayer Perceptron", 
% IEEE Trans Neural Netw Learn Syst. 2016 Apr;27(4):809-21. doi: 10.1109/TNNLS.2015.2424995. Epub 2015 May 7.


AA = (A') * A;

Lf = max(eig(AA));
Li = 1/Lf;
alp = Lam * Li;
M = size(A,2);
N = size(B,2);
W = zeros(M,N);
Yk = W;
Tk = 1;
L1 = 2 * Li * AA;
L2 = 2 * Li * A' * B;
%%
for i = 1:Itrs,
  ck = Yk - L1*Yk + L2;
  X1 = (max(abs(ck)-alp,0)).*sign(ck);
  Tk1 = 0.5 + 0.5*sqrt(1+4*Tk^2);
  tt = (Tk-1)/Tk1;
  Yk = X1 + tt*(W-X1);
  Tk = Tk1;W = X1;
end


