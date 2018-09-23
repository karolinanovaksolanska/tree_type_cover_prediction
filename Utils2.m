classdef Utils2
    
    properties
        GT
    end
    
    methods
        function   U = Utils2(GroundTruth)
         U.GT=GroundTruth;
        end
            
        function c=covert2logical(U,Y,label)
            if nargin < 3
                label='anomaly';
            end    
                if islogical(Y)
                 c=Y;                 
                elseif iscell(Y)
                 c=strcmp(Y,label);                 
                elseif min(size(Y))==1
                   c=Y>0.5;                  
                else 
                  [~,dim]=min(size(Y));
                  [~,c]=max(Y,[],dim);
                  c=c-1;
                end
             if size(c)~=size(U.GT)
                   c=c';
             end    
        end
        
        function acc=accuracyMC(U,Y)
           acc=sum(U.GT==Y);
           acc=acc/length(Y);
        end
        
        function fp=falsePositives(U,Y)
            if ~islogical(Y)
                Y=U.covert2logical(Y);
            end
             if size(U.GT,1)~=size(Y,1)
                Y=Y';
            end
            fp=sum(and(Y,~U.GT));
        end
    
        function fn=falseNegatives(U,Y)
            Y=U.covert2logical(Y);
            y=Y(U.GT);
            y=y-1;
            fn=-sum(y);
        end
        function acc=accuracy(U,Y)
            if ~islogical(Y)
                Y=U.covert2logical(Y);
            end
            if size(U.GT,1)~=size(Y,1)
                Y=Y';
            end
            y=Y==U.GT;
            acc=sum(y)/length(Y);
        end
        function r=recall(U,Y)
            Y=U.covert2logical(Y);
            y=and(Y,U.GT);
            r=sum(y)/sum(U.GT);
        end
        function r=precision(U,Y)
            Y=U.covert2logical(Y);
            y=and(Y,U.GT);
            r=sum(y)/sum(Y);
        end
        
          function fnr=falseNegativeRate(U,Y)
            jednicek=sum(U.GT); 
              if jednicek==0
                fnr=0;
            else   
            fn=U.falseNegatives(Y);
            fnr=fn/jednicek;
              end
          end
         function fpr=falsePositiveRate(U,Y)
             nul=sum(~U.GT);
             if nul==0
                fpr=0;
            else   
            fp=U.falsePositives(Y);
            fpr=fp/nul;
              end
         end
         function tp=truePositives(U,Y)
             tp=sum(and(U.GT,Y));
         end
         
         function tpr=truePositiveRate(U,Y)
            tp=U.truePositives(Y);
            tpr=tp/sum(U.GT);
         end
        
    end
end

