function Ytest = SVMTest(supportVector, Xtest, kernelType, delta)
%SVM测试

%supportVector.alpha = nPart*1
%supportVector.X     = dim*nPart
%supportVector.Y     = 1*nPart
%Xtest               = dim*nn

bStar = GetBstar(supportVector, kernelType, delta);%1*1

%见reference中的Eq. 3-17
%sgn{(w*x)-b} 展开后的(xi*x)
wx = (supportVector.alpha' .* supportVector.Y) * KernelFunc(supportVector.X, Xtest, kernelType, delta);%1*nn

Ytest = sign(wx - bStar);%1*nn
end

