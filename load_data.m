function [x1,x2] = load_data(dir)

classes = load(dir);

x1 = 0;
x2 = 0;
c1 = 1;
c2 = 1;

for i = 1:length(classes)
    if classes(i,3)
        x1(c1,1:2) = classes(i,1:2);
        c1 = c1 + 1;
    else
        x2(c2,1:2) = classes(i,1:2);
        c2 = c2 + 1;
    end
end
end