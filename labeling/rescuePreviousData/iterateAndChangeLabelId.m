function [pixelLabelImg] = iterateAndChangeLabelId(pixelLabelImg, mappingList)
%iterateAndChangeLabelId()
%This function takes a pixel label image and the mapping list. It changes
%the current label ID to a new label ID. The mapping between old and new
%label ID takes place in the "myMappingList.csv" file.

for i=1:1:size(pixelLabelImg, 1) %rows
    for k=1:1:size(pixelLabelImg, 2) %columns
        if pixelLabelImg(i,k) ~= 0 %unlabeled is always zero
            validID = searchValidId(mappingList, pixelLabelImg(i,k));
            pixelLabelImg(i, k) = validID;
        end
    end
end

end

