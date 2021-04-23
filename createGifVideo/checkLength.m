function [output1,output2, output3] = checkLength(varargin)
%checkLength Summary of this function goes here
% This function takes two structs and retruns it with the same length of elements.
% If one of the vectors is to long, the last view elements are skiped.
%   Detailed explanation goes here

length1=length(varargin{1, 1});
length2=length(varargin{1, 2});

% two input vectors
if length(varargin) == 2
    delta = abs(length1 - length2);
    if length1 < length2
        varargin{1, 2} = varargin{1, 2}(1:end - delta);
        output1 = varargin{1, 1};
        output2 = varargin{1, 2};
    elseif length1 > length2
        varargin{1, 1} = varargin{1, 1}(1:end - delta);
        output1 = varargin{1, 1};
        output2 = varargin{1, 2};
    else
        output1 = varargin{1, 1};
        output2 = varargin{1, 2};
    end

% three input vectors
elseif length(varargin) == 3
    length3=length(varargin{1, 3});
    
    if (length1 < length2) && (length1 < length3)
        delta2 = abs(length2 - length1);
        delta3 = abs(length3 - length1);
        varargin{1, 2} = varargin{1, 2}(1:end - delta2);
        varargin{1, 3} = varargin{1, 3}(1:end - delta3);
        output1 = varargin{1, 1};
        output2 = varargin{1, 2};
        output3 = varargin{1, 3};
        
    elseif (length2 < length1) && (length2 < length3)
        delta1 = abs(length1 - length2);
        delta3 = abs(length3 - length2);
        varargin{1, 1} = varargin{1, 1}(1:end - delta1);
        varargin{1, 3} = varargin{1, 3}(1:end - delta3);
        output1 = varargin{1, 1};
        output2 = varargin{1, 2};
        output3 = varargin{1, 3};

    elseif (length3 < length1) && (length3 < length2)
        delta1 = abs(length1 - length3);
        delta2 = abs(length2 - length3);
        varargin{1, 1} = varargin{1, 1}(1:end - delta1);
        varargin{1, 2} = varargin{1, 2}(1:end - delta2);
        output1 = varargin{1, 1};
        output2 = varargin{1, 2};
        output3 = varargin{1, 3};
        
    else
        output1 = varargin{1, 1};
        output2 = varargin{1, 2};
        output3 = varargin{1, 3};
    end
end


end

