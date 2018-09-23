% Multiclass SVM
u=unique(MyTrain);
numClasses=length(u);
result = zeros(length(MxTest(:,1)),1);
models = {};
%build models
for k=1:numClasses
    %Vectorized statement that binarizes Group
    %where 1 is the current class and 0 is all other classes
    G1vAll=(MyTrain==u(k));
    models{k, 1} = fitcsvm(MxTrain,G1vAll, 'KernelFunction', 'linear');
end

%classify test cases
for j=1:size(MxTest,1)
    max = -Inf;
    class = 0;
    for k=1:numClasses
        [~,score] = predict(models{k},MxTest(j,:));
        %disp(score)
        if(score(2) >= max)
            max = score(2);
            class = u(k);
        end
    end
    result(j) = class;
end

%utils.accuracyMC(result) 'KernelFunction', 'polynomial', 'PolynomialOrder', 2
% accuracyMC = 0.1163

%'KernelFunction', 'linear'
% accuracyMC = 0.9635

%'KernelFunction', 'gaussian'
% accuracyMC = 0.0781

%'KernelFunction', 'polynomial', 'PolynomialOrder', 3
% accuracyMC = 0.1024

%'KernelFunction', 'polynomial', 'PolynomialOrder', 4
% accuracyMC = 0.1024

% strm = fitrtree(data3.x_tr, data3.y_tr);
% prdtr = predict(strm, data3.x_tst);
% accuracyMC = 0.4722

% strm = fitctree(data3.x_tr, data3.y_tr);
% prdtr = predict(strm, data3.x_tst);
% accuracyMC = 0.9201
