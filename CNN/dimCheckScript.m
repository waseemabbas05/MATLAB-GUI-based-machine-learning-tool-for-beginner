%%
imagesc(Train_X(:,:,1))

%%
for i=1:60000
    a(i,:,:)=reshape(Train_X(:,:,i),[28,28]);
    display(num2str(100*i/60000))
end
%%
imagesc(reshape(b(1,:,:),[28,28]))
%%
[b,n]  = shiftdim(Train_X,2);
%%
Train_X=b;
Train_Y=Train_Y';
%%
[b,n]  = shiftdim(Test_X,2);
Test_X=b;
Test_Y=Test_Y';
%% 
save('mnist_uint8.mat')

%%
Inputs=[Train_X;Test_X];
%%
Targets=[Train_Y;Test_Y];
%%
save('MNIST_Images.mat','Inputs','Targets');

%%
[b,n]  = shiftdim(Train_X,1);
imagesc(reshape(b(:,:,1),[28,28])')

%%
ImRows=size(Inputs,2);
ImCols=size(Inputs,3);
LowerDim=min([ImRows ImCols]);
EndDim=4;
TempDim=LowerDim;
ConvSize=5;
Scale=2;
n=1;
while TempDim>=EndDim
    d(n)=TempDim
    TempDim=TempDim-ConvSize+1;
    TempDim=round(TempDim/Scale)
    n=n+1;
end

%%
NL=3;
C=5;
E=4;
L=28;
for i=1:NL
    B(i)=C;
end
B(NL+1)=E;
if NL<10
    for i=NL+2:10
        B(i)=0;
    end
end
%%

syms S
f=B(1)*1+B(2)*S+B(3)*S^2+B(4)*S^3+B(5)*S^4+B(6)*S^5+B(7)*S^6+B(8)*S^7+B(9)*S^8+B(10)*S^9-L;
Sa=solve(f==0)

%%
L=76;E=6;C=4;N=3
S=((L+4)/(E+C))^(1/N)






