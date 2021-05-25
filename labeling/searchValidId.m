function [validID] = searchValidId(mappingList, invalidId)
%This function takes the invalid ID and the mapping tabel and retruns the
%valid ID.

if invalidId == 0 % unlabeled is always zero
    validID = 0;    
else
    dim = size(mappingList);
    for i=1:dim(1)
        if mappingList.invalidPixelLabelID(i)== invalidId
            validID = mappingList.validPixelLabelID(i);
            break;
        end
    end
end

end

