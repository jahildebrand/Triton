function clusterID = ct_run_CW_cluster(clusterID,distClickEFull,itrMax)
% for iRow = 1:length(uMergeNodeID)
%     distClickEFull(:,iRow) = distClickEFull(:,iRow).*...
%      countsMergeNodeID(iRow);
% end
% Begin CW loops
% Biemann, C. (2006). Chinese Whispers - An Efficient Graph Clustering 
% Algorithm And Its Application To Natural Language Processing Problems.

list2cluster = clusterID(~isnan(clusterID));
distClickEIdx = 1:size(distClickEFull,1);
noChange = 0;
cwItr = 1;
% itrMax = 10;
while ~noChange && (cwItr<=itrMax)
    rOrder = randperm(length(list2cluster));% randomize order
    noChange = 1; % set no change flag to 1, it will be flipped to 0 as soon as a change is made    
   
    for iNode = 1:length(list2cluster)    
        thisNode = list2cluster(rOrder(iNode));
        
        % which nodes are connected to this one?
        linkedNodes = distClickEIdx(distClickEFull(thisNode,:)>0);        
        linkedNodeLables = clusterID(linkedNodes);
        % what categories do those nodes fall into?
        uniqueLinkedNodeLabels = unique(linkedNodeLables(~isnan(linkedNodeLables)));
        categoryWeight = nan(size(uniqueLinkedNodeLabels));
        for iUNodes = 1:length(uniqueLinkedNodeLabels)
            thisCategory = uniqueLinkedNodeLabels(iUNodes);
            nodesInCategory = linkedNodeLables == thisCategory;
            categoryWeight(iUNodes) = nansum(distClickEFull(thisNode,...
                linkedNodes(nodesInCategory)));
        end
            
        [~,newIdx] = nanmax(categoryWeight);
        newLabel = uniqueLinkedNodeLabels(newIdx);
        if newLabel ~= clusterID(thisNode)
            clusterID(thisNode) = newLabel;
            noChange = 0;
        end
    end
    cwItr = cwItr + 1;
end
fprintf('%0.0f iterations required\n',cwItr-1);