apiUrl = ['https://api.github.com/repos/braph-software/BRAPH-2/contents/braph2genesis?ref=develop'];
options = weboptions('ContentType', 'json');
response = webread(apiUrl, options);

for i = 1:length(response)
    disp(['File: ', response(i).name]);
    disp(['File: ', response(i).type]);
end

fileUrl = response_genesis.download_url;
fileName = response_genesis.name;
 
localFolder = 'downloaded_files';
mkdir(localFolder)

% Loop through each file in the folder
for i = 1:length(response)
    if strcmp(response(i).type, 'dir')
        % Get the file URL and name
        fileUrl = response(i).download_url;
        fileName = response(i).name;

        % Download the file
        fprintf('Downloading %s...\n', fileName);
        fileContent = webread(fileUrl);

        % Save the file locally
        localFilePath = fullfile(localFolder, fileName);
        fid = fopen(localFilePath, 'w');
        fwrite(fid, fileContent);
        fclose(fid);
    end
end
