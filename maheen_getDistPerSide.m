function [ distPerSide ] = maheen_getDistPerSide( distCell )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
        intBin=zeros(1,2);
        distances=zeros(1,0);
        distPerSide=cell(size(distCell));
        for i=1:numel(distCell)
            check=sum(sum(distCell{i}<0));
            if check==2
                intBin(i)=-2;
            else
                intBin(i)=-1*mod(check,2);
            end
        end
        
        if sum(intBin)<-3 || sum(intBin==-1)>1
            distances=[0];
            distPerSide={distances,distances};
        elseif sum(intBin)==-3
            for i=1:numel(distCell)
                if intBin(i)==-1
                    check=distCell{i}<0;
                    if sum(sum(check))==3
                        check=~check;
                    end
%                     ind=find(check);
                    distances=abs(distCell{i}(check));
                elseif intBin(i)==-2
                    distances=abs(diag(distCell{i}));
                end
                distPerSide{i}=distances;
            end
        else
            for i=1:numel(distCell)
                if intBin(i)==0
                    distances=min(min(abs(distCell{i})));
                elseif intBin(i)==-1
                    check=distCell{i}<0;
                    if sum(sum(check))==3
                        check=~check;
                    end
                    ind=find(check);
                    binWhichDist=ones(size(distCell{i}));
                    if ind==1
                        binWhichDist(4)=0;
                    elseif ind==2
                        binWhichDist(3)=0;
                    elseif ind==3
                        binWhichDist(2)=0;
                    else
                        binWhichDist(1)=0;
                    end
                    distances=abs(distCell{i}(binWhichDist>0));
                    if ind==1
                        distances=distances([2,1,3]);
                    elseif ind==4
                        distances=distances([1,3,2]);
                    end
                elseif intBin(i)==-2
                    distances=abs(diag(distCell{i}));
                end
                distPerSide{i}=distances;
            end
        end

end

