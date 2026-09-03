%Will order columns of data csv by increasing face centroid
function fixedMatrix = reorderFaces(Tbl)
headers = Tbl.Properties.VariableNames;
headers = headers(2:end);
fixedHeaders=zeros(size(headers));

for i=1:numel(headers)
    tempStore = char(headers(i));
    tempStore = tempStore(2:end-4);
    tempStore = strrep(tempStore,'_','.');
    tempStore = str2double(tempStore);
    fixedHeaders(i) = tempStore;
end
tempMatrix= table2array(Tbl(2:end,2:end));
tempMatrix = [fixedHeaders; tempMatrix];
[~,idx] = sort(tempMatrix(1,:),'ascend');
tempMatrix = tempMatrix(:,idx);
fixedMatrix = tempMatrix(2:end,:);
end
