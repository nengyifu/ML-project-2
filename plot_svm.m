function [] = plot_svm(L,X1,X2,i_sv,Yd)
len = length(L)/2;
X = L';
hold on;

plot(L(1:len,1),L(1:len,2),'b*',L(len+1:end,1),L(len+1:end,2),'ro')
plot(X(1,i_sv),X(2,i_sv),'go')
grid on

contour(X1,X2,Yd,'m'); 
% title('SVM results')
% xlabel("x coordinate")
% ylabel("y coordinate")
% legend('class 1', 'class2', 'support vectors', 'decision boundary')

title('Income Classifcation')
xlabel("age")
ylabel("education (year)")
legend('high income', 'low income', 'support vectors', 'decision boundary')
 legend('Location','southeast')
end