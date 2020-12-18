function sim = similarity(s1,s2)
%SIMILARITY Summary of this function goes here
%   Detailed explanation goes here
s1 = unique(s1);
s2 = unique(s2);
common = intersect(s1,s2);
sim = length(common)/(log(length(s1)) + log(length(s2)));
end

