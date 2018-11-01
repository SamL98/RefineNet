



function node_scores=my_softmax(node_scores)
  

if size(node_scores, 1)>1
    node_scores=node_scores(:,2:end);
    
    node_scores=bsxfun(@minus, node_scores, max(node_scores, [], 2));
    node_scores=exp(node_scores);
    node_scores=bsxfun(@rdivide, node_scores,...
        sum(node_scores, 2));
    
%     tmp_node_scores=node_scores;
%     node_scores=zeros(size(node_scores, 1), size(node_scores, 2)+1);
%     node_scores(:,2:end)=tmp_node_scores(:,:);
%     node_scores(:,1)=0;
else
    node_scores=node_scores(2:end); % added
    node_scores=node_scores-max(node_scores);
    node_scores=exp(node_scores);
    node_scores=node_scores./sum(node_scores);
end


end