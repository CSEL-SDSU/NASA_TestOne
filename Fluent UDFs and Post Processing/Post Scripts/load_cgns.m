function [table, info] = load_cgns(file,byLine)
    % Jack Volponi
    % Update Logs:
    % Last Updated 10/31/2024
    % Updated 11/1/2024: Added Functionality to work for Nodal and Cell
    % Centered Values. (# of values for nodal and cell center will be
    % different, so extra indicies will be zero. Nodal Coordinates are
    % always given by fluent, Cell Centered Coordinates can be selected
    % from the quantities tab in the solution data export. 
    % function to load cgns (CFD General Notation System) data files into
    % a table. Basically readtable() for .cgns
    %
    % Updated 1/9/2025 To add capability to label which data points
    % correspond to which line in fluent. Only works if only lines are
    % output
    % Updated 9/12/2025: Fluent 2025R1 seemed to change the structure of
    % exported .cgns files, so modified code to find the proper group
    % indicies instead of preset group indicies
    % Updated 3/4/2026: Fluent 2025R2 modified the FlowSolution_t group to
    % distinguish between marking the data as nodal or cell center. Nodal
    % solution data is denoted with '/Base/Zone/FlowSolution.N:1' and Cell
    % Center data is denoted with '/Base/Zone/FlowSolution.E:1'. As a note,
    % the coordinates are ALWAYS still nodal coordinates. To get the cell
    % center coordinates, the X-Coordinate and Y-Coordinate must selected
    % as additional output quantities .
    % Updated 4/21/2026: Added zone column which will assign a zone to
    % where each data point comes from.

    arguments
        file {mustBeFile}
        byLine (1,1) logical = 0 %must be logical
    end
    
    %Gather the info about orgainization of the CGNS file. 
    info = h5info(file); 

    %Use the info struct to count the number of output scalars and the
    
    %number of coordinates, ex 2D/Axissymmetic = 2, 3D = 3;
    %info.Groups(1).Groups(3).Groups(2).Groups
    %Scoping through groups to find proper branch
    base_grp_idx = find(string({info.Groups.Name})=="/Base"); %index of first group level that Base belongs to
    base_zone_grp_idx = find(string({info.Groups(base_grp_idx).Groups.Name})=='/Base/Zone'); %Index of base subgroup level that zone belongs to
    base_zone_GC_idx = find(string({info.Groups(base_grp_idx).Groups(base_zone_grp_idx).Groups.Name}) == '/Base/Zone/GridCoordinates'); %Index of base/zone subgroup that grid coordinates belogns to

    % num_coordinates = length(info.Groups(1).Groups(2).Groups(2).Groups);
    num_coordinates = length(info.Groups(base_grp_idx).Groups(base_zone_grp_idx).Groups(base_zone_GC_idx).Groups);

    %Number of scalars that user chose to export

    % Changed '/Base/Zone/FlowSolution.N:1' to
    % '/Base/Zone/FlowSolution.N:1' '/Base/Zone/FlowSolution.E:1'
    % base_zone_FS = find(string({info.Groups(base_grp_idx).Groups(base_zone_grp_idx).Groups.Name}) == '/Base/Zone/FlowSolution.E:1'); %Index of base/zone subgroup that grid coordinates belogns to
  
    % Backwards compatible version of previous line 
    base_zone_FS = find(contains(string({info.Groups(base_grp_idx).Groups(base_zone_grp_idx).Groups.Name}) , '/Base/Zone/FlowSolution.'));

    num_scalars = length(info.Groups(base_grp_idx).Groups(base_zone_grp_idx).Groups(base_zone_FS).Groups);
    
    %total number of columns in output table
    num_cols = num_coordinates + num_scalars;
    
    %Loop through number of coordinates and make them the first columns.
    %Then loop throgh all the outputted quantities and make them the
    %subsequent columns
    for i=1:num_cols 
        if i <= num_coordinates 
            col_groups(i) = string(info.Groups(base_grp_idx).Groups(base_zone_grp_idx).Groups(base_zone_GC_idx).Groups(i).Name);
            name = split(col_groups(i),'/');
            col_name(i) = name(end);
            data(:,i) = h5read(file,col_groups(i)+"/"+info.Groups(base_grp_idx).Groups(base_zone_grp_idx).Groups(base_zone_GC_idx).Groups(i).Datasets.Name);
        else
            col_groups(i) = info.Groups(base_grp_idx).Groups(base_zone_grp_idx).Groups(base_zone_FS).Groups(i-num_coordinates).Name;
            name = split(col_groups(i),'/');
            col_name(i) = name(end);
            if find((col_name(i) == col_name) ~= logical([zeros(1,length(col_name)-1) 1])) > 0
                col_name(i) = col_name(i)+"_Cell_Center";
            end
            col_length = length(h5read(file,col_groups(i)+"/"+info.Groups(base_grp_idx).Groups(base_zone_grp_idx).Groups(base_zone_FS).Groups(i-num_coordinates).Datasets.Name));
            data(1:col_length,i) = h5read(file,col_groups(i)+"/"+info.Groups(base_grp_idx).Groups(base_zone_grp_idx).Groups(base_zone_FS).Groups(i-num_coordinates).Datasets.Name);
        end
    end
    
    %Convert Coordinate arrays to single precision b/s fluent may have
    %round off errors for position data
    %convert x,y,z coordinates to single precision so that they will
    % be unique values
    %data(:,1:3) = single(data(:,1:3)); 
    % if length(unique(col_name)) ~= col_length
    %     col_name(col_name==)
    data = array2table(data); %convert data array to table
    data.Properties.VariableNames = cellstr(col_name); %Set variable names to scalar and coordinate names
    table = data;
    
    
    % Loop over all zones and assign the zone name to the row that the cell
    % belongs to
    physical_zones = string({info.Groups(base_grp_idx).Groups(base_zone_grp_idx).Groups.Name});

    exclusion_strings = ["FlowSolution", "GridCoordinates", "ZoneBC", "ZoneIterativeData","ZoneType"];

    physical_zones = physical_zones(~contains(physical_zones, exclusion_strings));
    % physical_zones = physical_zones(5:end);

    % Zone/boundary matching
    % boundaries = string({info.Groups(base_grp_idx).Groups(base_zone_grp_idx).Groups(3).Groups.Name});
    % boundary_names = erase(boundaries, "/Base/Zone/ZoneBC/");
    % zone_names = erase(physical_zones, "/Base/Zone/");
    % 
    % boundary_names = regexprep(boundary_names, '-[^-]+$', '');

    % Create array for zone name
    zone_name = strings(height(table), 1);

    for i = 1:length(physical_zones)
        % Read Element range for each zone
        ds = physical_zones(i) + "/ElementRange/ data";

        element_range = h5read(file,ds);

        zone_name(element_range(1):element_range(2)) = erase(physical_zones(i), "/Base/Zone/");

        % if num_coordinates < 3
        %     if any(startsWith(boundary_names,zone_names(i)))
        %         %If is zone is a boundary, face centroids need to be recomputed
        % 
        %         %Read the Connectivity information
        %         ds_connectivty = physical_zones(i) + "/ElementConnectivity/ data";
        %         element_connectivity = h5read(file, ds_connectivty);
        % 
        %         element_types = element_connectivity(1:3:end);
        % 
        %         if any(element_types ~= 3)
        %             error("Only linear bar element types supported (type 3) \n");
        %         end
        %         element_node1 = element_connectivity(2:3:end);
        %         element_node2 = element_connectivity(3:3:end);
        % 
        %         % Calculate face centroid
        %         x_nodal = h5read(file, info.Groups(base_grp_idx).Groups(base_zone_grp_idx).Groups(base_zone_GC_idx).Groups(1).Name + "/ data");
        %         y_nodal = h5read(file, info.Groups(base_grp_idx).Groups(base_zone_grp_idx).Groups(base_zone_GC_idx).Groups(2).Name + "/ data");
        % 
        %         centroid_x = (x_nodal(element_node1) + x_nodal(element_node2))/2;
        %         centroid_y = (y_nodal(element_node1) + y_nodal(element_node2))/2;
        % 
        %         %Overwrite Coordinates with correct coordinates
        %         table.CoordinateX_Cell_Center(element_range(1):element_range(2)) = centroid_x;
        %         table.CoordinateY_Cell_Center(element_range(1):element_range(2)) = centroid_y;
        %     end
        % end
    end

    % Add the the zones column to the table
    table.ZoneName = zone_name;

    % if number of coordinates  < 2, calculate proper face Centroids

    % Loop over all boundaries in ZoneBC and compute the proper face centroid 
    
    %Read PointList

    % boundaries = strings{info.Groups(base_zone_grp_idx).Groups(base_zone_grp_idx).Groups}

    %% FIX HERE and DOWN 
    % Will need to fix it for a by line case, but I am eliminating that
    % soon so this section will be obsolete, so leaving it broken
    
    

    if byLine == 1
        num_lines = length(info.Groups(1).Groups(2).Groups(5:end));
        table.line = zeros(size(table.CoordinateX))
        for i = 1:num_lines
            Cell_id_range = h5read(file,info.Groups(1).Groups(2).Groups(i+4).Groups(2).Name +"/ data")
            table.CoordinateX(table.Cell_Id>=1 & table.Cell_Id<=200)
        end
    end
end