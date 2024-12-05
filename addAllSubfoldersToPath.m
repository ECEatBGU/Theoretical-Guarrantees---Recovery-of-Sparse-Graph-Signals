function addAllSubfoldersToPath()
    % Adds the current folder and all its subfolders to the MATLAB path.
    %
    % If the script is saved to a file, it uses the folder of the script.
    % Otherwise, it uses the current working directory.

    % Determine the parent folder
    if isdeployed
        % If the code is deployed, use the current directory
        parentFolder = pwd;
    else
        % If running in MATLAB, use the folder of the script (if available)
        parentFolder = fileparts(mfilename('fullpath'));
        if isempty(parentFolder)
            % If not saved in a file, default to the current directory
            parentFolder = pwd;
        end
    end

    % Validate that the parentFolder exists
    if ~isfolder(parentFolder)
        error('The determined folder does not exist: %s', parentFolder);
    end

    % Generate a list of all subfolders
    folderList = genpath(parentFolder);

    % Add the folders to the MATLAB path
    addpath(folderList);

    % Display confirmation
    disp(['All folders and subfolders under "', parentFolder, '" have been added to the MATLAB path.']);
end