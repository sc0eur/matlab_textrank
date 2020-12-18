str = [
    "The fox jumped over the dog."
    "The lazy dog saw a fox jumping."
    "The quick brown fox jumped over the lazy dog."
    "There seem to be animals jumping over other animals."
    "There are quick animals and lazy animals"];
documents = tokenizedDocument(str);
n = length(documents);
scores = zeros(n, n);
s = [];
t = [];
weights = [];
for i = 1:n
    for j = 1:n
        scores(i, j) = similarity(string(documents(i)), string(documents(j)));
        if j > i
            idx = (n*(i-1))+j;
            s = [s; i];
            t = [t; j];
            weights = [weights; scores(i, j)];
        end
    end
end

G = graph(s, t, weights);
plot(G,'EdgeLabel',G.Edges.Weight)
pr = zeros(1,n);
for i = 1:n
    pr(i) = sum(scores(i,:));
end
numIter = 100;
d = 0.85;
eps = 1e-3;
for i = 1:numIter
    prev = pr;
    for k = 1:n
        for j = 1:n
            if k ~= j
                pr(k) = pr(j)*sum(scores(k,:)/sum(scores(j,:)))*d + (1-d);
                
            end
        end
    end
    if norm(pr-prev)<eps
        break
    end
end
figure
bar(pr)
xlabel("Номер документа")
ylabel("Важность документа")