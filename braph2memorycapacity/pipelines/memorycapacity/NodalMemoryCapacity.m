classdef NodalMemoryCapacity < Measure
	%NodalMemoryCapacity is the graph NodalMemoryCapacity.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The nodal memory capacity measures how well a given node manages to encode a random input signal applied to itself.
	% This nodal memory capacity is determined by training the nodal output to reproduce delayed input time series 
	% and comparing the delayed input applied to the given node with its output. 
	% A high memory capacity indicates that the node has high capacity to remember and process the temporal 
	% information contained in the input signal.
	%
	% The list of NodalMemoryCapacity properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the NodalMemoryCapacity.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the NodalMemoryCapacity.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the NodalMemoryCapacity.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the NodalMemoryCapacity.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the NodalMemoryCapacity.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the NodalMemoryCapacity.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the NodalMemoryCapacity.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
	%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
	%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
	%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
	%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
	%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the average nodal memory capacity across all trials.
	%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
	%  <strong>16</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
	%  <strong>17</strong> <strong>TRIALS</strong> 	TRIALS (parameter, scalar) is the number of trials.
	%  <strong>18</strong> <strong>TRAINING_SAMPLES</strong> 	TRAINING_SAMPLES (parameter, scalar) is the number of training samples (length of input time series).
	%  <strong>19</strong> <strong>TAU_MAX</strong> 	TAU_MAX (parameter, scalar) is the maximum delay to be considered.
	%  <strong>20</strong> <strong>MC_ALL_TRIALS</strong> 	MC_ALL_TRIALS (result, cell) is the nodal memory capacity at all trials.
	%  <strong>21</strong> <strong>MC_CALC</strong> 	MC_CALC (query, cell) calculates nodal memory capacity, given weighted connectivity matrix, input signal and maximum delay.
	%
	% NodalMemoryCapacity methods (constructor):
	%  NodalMemoryCapacity - constructor
	%
	% NodalMemoryCapacity methods:
	%  set - sets values of a property
	%  check - checks the values of all properties
	%  getr - returns the raw value of a property
	%  get - returns the value of a property
	%  memorize - returns the value of a property and memorizes it
	%             (for RESULT, QUERY, and EVANESCENT properties)
	%  getPropSeed - returns the seed of a property
	%  isLocked - returns whether a property is locked
	%  lock - locks unreversibly a property
	%  isChecked - returns whether a property is checked
	%  checked - sets a property to checked
	%  unchecked - sets a property to NOT checked
	%
	% NodalMemoryCapacity methods (display):
	%  tostring - string with information about the nodal memory capacity
	%  disp - displays information about the nodal memory capacity
	%  tree - displays the tree of the nodal memory capacity
	%
	% NodalMemoryCapacity methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two nodal memory capacity are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the nodal memory capacity
	%
	% NodalMemoryCapacity methods (save/load, Static):
	%  save - saves BRAPH2 nodal memory capacity as b2 file
	%  load - loads a BRAPH2 nodal memory capacity from a b2 file
	%
	% NodalMemoryCapacity method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the nodal memory capacity
	%
	% NodalMemoryCapacity method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the nodal memory capacity
	%
	% NodalMemoryCapacity methods (inspection, Static):
	%  getClass - returns the class of the nodal memory capacity
	%  getSubclasses - returns all subclasses of NodalMemoryCapacity
	%  getProps - returns the property list of the nodal memory capacity
	%  getPropNumber - returns the property number of the nodal memory capacity
	%  existsProp - checks whether property exists/error
	%  existsTag - checks whether tag exists/error
	%  getPropProp - returns the property number of a property
	%  getPropTag - returns the tag of a property
	%  getPropCategory - returns the category of a property
	%  getPropFormat - returns the format of a property
	%  getPropDescription - returns the description of a property
	%  getPropSettings - returns the settings of a property
	%  getPropDefault - returns the default value of a property
	%  getPropDefaultConditioned - returns the conditioned default value of a property
	%  checkProp - checks whether a value has the correct format/error
	%
	% NodalMemoryCapacity methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NodalMemoryCapacity methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NodalMemoryCapacity methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NodalMemoryCapacity methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatTag - returns the tag of a format
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% To print full list of constants, click here <a href="matlab:metaclass = ?NodalMemoryCapacity; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NodalMemoryCapacity constants</a>.
	%
	
	properties (Constant) % properties
		WAITBAR = 16; %CET: Computational Efficiency Trick
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = 9;
		WAITBAR_FORMAT = 4;
		
		TRIALS = 17; %CET: Computational Efficiency Trick
		TRIALS_TAG = 'TRIALS';
		TRIALS_CATEGORY = 3;
		TRIALS_FORMAT = 11;
		
		TRAINING_SAMPLES = 18; %CET: Computational Efficiency Trick
		TRAINING_SAMPLES_TAG = 'TRAINING_SAMPLES';
		TRAINING_SAMPLES_CATEGORY = 3;
		TRAINING_SAMPLES_FORMAT = 11;
		
		TAU_MAX = 19; %CET: Computational Efficiency Trick
		TAU_MAX_TAG = 'TAU_MAX';
		TAU_MAX_CATEGORY = 3;
		TAU_MAX_FORMAT = 11;
		
		MC_ALL_TRIALS = 20; %CET: Computational Efficiency Trick
		MC_ALL_TRIALS_TAG = 'MC_ALL_TRIALS';
		MC_ALL_TRIALS_CATEGORY = 5;
		MC_ALL_TRIALS_FORMAT = 16;
		
		MC_CALC = 21; %CET: Computational Efficiency Trick
		MC_CALC_TAG = 'MC_CALC';
		MC_CALC_CATEGORY = 6;
		MC_CALC_FORMAT = 16;
	end
	methods % constructor
		function m = NodalMemoryCapacity(varargin)
			%NodalMemoryCapacity() creates a nodal memory capacity.
			%
			% NodalMemoryCapacity(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NodalMemoryCapacity(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NodalMemoryCapacity properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the NodalMemoryCapacity.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the NodalMemoryCapacity.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the NodalMemoryCapacity.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the NodalMemoryCapacity.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the NodalMemoryCapacity.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the NodalMemoryCapacity.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the NodalMemoryCapacity.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SHAPE</strong> 	SHAPE (constant, scalar) is the measure shape Measure.NODAL.
			%  <strong>10</strong> <strong>SCOPE</strong> 	SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.
			%  <strong>11</strong> <strong>PARAMETRICITY</strong> 	PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.
			%  <strong>12</strong> <strong>COMPATIBLE_GRAPHS</strong> 	COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
			%  <strong>13</strong> <strong>G</strong> 	G (data, item) is the measure graph.
			%  <strong>14</strong> <strong>M</strong> 	M (result, cell) is the average nodal memory capacity across all trials.
			%  <strong>15</strong> <strong>PFM</strong> 	PFM (gui, item) contains the panel figure of the measure.
			%  <strong>16</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
			%  <strong>17</strong> <strong>TRIALS</strong> 	TRIALS (parameter, scalar) is the number of trials.
			%  <strong>18</strong> <strong>TRAINING_SAMPLES</strong> 	TRAINING_SAMPLES (parameter, scalar) is the number of training samples (length of input time series).
			%  <strong>19</strong> <strong>TAU_MAX</strong> 	TAU_MAX (parameter, scalar) is the maximum delay to be considered.
			%  <strong>20</strong> <strong>MC_ALL_TRIALS</strong> 	MC_ALL_TRIALS (result, cell) is the nodal memory capacity at all trials.
			%  <strong>21</strong> <strong>MC_CALC</strong> 	MC_CALC (query, cell) calculates nodal memory capacity, given weighted connectivity matrix, input signal and maximum delay.
			%
			% See also Category, Format.
			
			m = m@Measure(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the nodal memory capacity.
			%
			% BUILD = NodalMemoryCapacity.GETBUILD() returns the build of 'NodalMemoryCapacity'.
			%
			% Alternative forms to call this method are:
			%  BUILD = M.GETBUILD() returns the build of the nodal memory capacity M.
			%  BUILD = Element.GETBUILD(M) returns the build of 'M'.
			%  BUILD = Element.GETBUILD('NodalMemoryCapacity') returns the build of 'NodalMemoryCapacity'.
			%
			% Note that the Element.GETBUILD(M) and Element.GETBUILD('NodalMemoryCapacity')
			%  are less computationally efficient.
			
			build = 1;
		end
		function m_class = getClass()
			%GETCLASS returns the class of the nodal memory capacity.
			%
			% CLASS = NodalMemoryCapacity.GETCLASS() returns the class 'NodalMemoryCapacity'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the nodal memory capacity M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('NodalMemoryCapacity') returns 'NodalMemoryCapacity'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('NodalMemoryCapacity')
			%  are less computationally efficient.
			
			m_class = 'NodalMemoryCapacity';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the nodal memory capacity.
			%
			% LIST = NodalMemoryCapacity.GETSUBCLASSES() returns all subclasses of 'NodalMemoryCapacity'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the nodal memory capacity M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('NodalMemoryCapacity') returns all subclasses of 'NodalMemoryCapacity'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('NodalMemoryCapacity')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NodalMemoryCapacity' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of nodal memory capacity.
			%
			% PROPS = NodalMemoryCapacity.GETPROPS() returns the property list of nodal memory capacity
			%  as a row vector.
			%
			% PROPS = NodalMemoryCapacity.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the nodal memory capacity M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('NodalMemoryCapacity'[, CATEGORY]) returns the property list of 'NodalMemoryCapacity'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('NodalMemoryCapacity')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3 9 10 11 12];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 17 18 19];
				case 4 % Category.DATA
					prop_list = [5 13];
				case 5 % Category.RESULT
					prop_list = [14 20];
				case 6 % Category.QUERY
					prop_list = [8 21];
				case 9 % Category.GUI
					prop_list = [15 16];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of nodal memory capacity.
			%
			% N = NodalMemoryCapacity.GETPROPNUMBER() returns the property number of nodal memory capacity.
			%
			% N = NodalMemoryCapacity.GETPROPNUMBER(CATEGORY) returns the property number of nodal memory capacity
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the nodal memory capacity M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('NodalMemoryCapacity') returns the property number of 'NodalMemoryCapacity'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('NodalMemoryCapacity')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 21;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 7;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 4;
				case 4 % Category.DATA
					prop_number = 2;
				case 5 % Category.RESULT
					prop_number = 2;
				case 6 % Category.QUERY
					prop_number = 2;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in nodal memory capacity/error.
			%
			% CHECK = NodalMemoryCapacity.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(NodalMemoryCapacity, PROP) checks whether PROP exists for NodalMemoryCapacity.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NodalMemoryCapacity:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:NodalMemoryCapacity:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:NodalMemoryCapacity:WrongInput]
			%  Element.EXISTSPROP(NodalMemoryCapacity, PROP) throws error if PROP does NOT exist for NodalMemoryCapacity.
			%   Error id: [BRAPH2:NodalMemoryCapacity:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('NodalMemoryCapacity')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 21 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NodalMemoryCapacity:' 'WrongInput'], ...
					['BRAPH2' ':NodalMemoryCapacity:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NodalMemoryCapacity.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in nodal memory capacity/error.
			%
			% CHECK = NodalMemoryCapacity.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(NodalMemoryCapacity, TAG) checks whether TAG exists for NodalMemoryCapacity.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NodalMemoryCapacity:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:NodalMemoryCapacity:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:NodalMemoryCapacity:WrongInput]
			%  Element.EXISTSTAG(NodalMemoryCapacity, TAG) throws error if TAG does NOT exist for NodalMemoryCapacity.
			%   Error id: [BRAPH2:NodalMemoryCapacity:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('NodalMemoryCapacity')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'WAITBAR'  'TRIALS'  'TRAINING_SAMPLES'  'TAU_MAX'  'MC_ALL_TRIALS'  'MC_CALC' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NodalMemoryCapacity:' 'WrongInput'], ...
					['BRAPH2' ':NodalMemoryCapacity:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NodalMemoryCapacity.'] ...
					)
			end
		end
		function prop = getPropProp(pointer)
			%GETPROPPROP returns the property number of a property.
			%
			% PROP = Element.GETPROPPROP(PROP) returns PROP, i.e., the 
			%  property number of the property PROP.
			%
			% PROP = Element.GETPROPPROP(TAG) returns the property number 
			%  of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PROPERTY = M.GETPROPPROP(POINTER) returns property number of POINTER of M.
			%  PROPERTY = Element.GETPROPPROP(NodalMemoryCapacity, POINTER) returns property number of POINTER of NodalMemoryCapacity.
			%  PROPERTY = M.GETPROPPROP(NodalMemoryCapacity, POINTER) returns property number of POINTER of NodalMemoryCapacity.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('NodalMemoryCapacity')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'WAITBAR'  'TRIALS'  'TRAINING_SAMPLES'  'TAU_MAX'  'MC_ALL_TRIALS'  'MC_CALC' })); % tag = pointer %CET: Computational Efficiency Trick
			else % numeric
				prop = pointer;
			end
		end
		function tag = getPropTag(pointer)
			%GETPROPTAG returns the tag of a property.
			%
			% TAG = Element.GETPROPTAG(PROP) returns the tag TAG of the 
			%  property PROP.
			%
			% TAG = Element.GETPROPTAG(TAG) returns TAG, i.e. the tag of 
			%  the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  TAG = M.GETPROPTAG(POINTER) returns tag of POINTER of M.
			%  TAG = Element.GETPROPTAG(NodalMemoryCapacity, POINTER) returns tag of POINTER of NodalMemoryCapacity.
			%  TAG = M.GETPROPTAG(NodalMemoryCapacity, POINTER) returns tag of POINTER of NodalMemoryCapacity.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('NodalMemoryCapacity')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nodalmemorycapacity_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SHAPE'  'SCOPE'  'PARAMETRICITY'  'COMPATIBLE_GRAPHS'  'G'  'M'  'PFM'  'WAITBAR'  'TRIALS'  'TRAINING_SAMPLES'  'TAU_MAX'  'MC_ALL_TRIALS'  'MC_CALC' };
				tag = nodalmemorycapacity_tag_list{pointer}; % prop = pointer
			end
		end
		function prop_category = getPropCategory(pointer)
			%GETPROPCATEGORY returns the category of a property.
			%
			% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the category of the
			%  property PROP.
			%
			% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the category of the
			%  property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CATEGORY = M.GETPROPCATEGORY(POINTER) returns category of POINTER of M.
			%  CATEGORY = Element.GETPROPCATEGORY(NodalMemoryCapacity, POINTER) returns category of POINTER of NodalMemoryCapacity.
			%  CATEGORY = M.GETPROPCATEGORY(NodalMemoryCapacity, POINTER) returns category of POINTER of NodalMemoryCapacity.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('NodalMemoryCapacity')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NodalMemoryCapacity.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nodalmemorycapacity_category_list = { 1  1  1  3  4  2  2  6  1  1  1  1  4  5  9  9  3  3  3  5  6 };
			prop_category = nodalmemorycapacity_category_list{prop};
		end
		function prop_format = getPropFormat(pointer)
			%GETPROPFORMAT returns the format of a property.
			%
			% FORMAT = Element.GETPROPFORMAT(PROP) returns the
			%  format of the property PROP.
			%
			% FORMAT = Element.GETPROPFORMAT(TAG) returns the
			%  format of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  FORMAT = M.GETPROPFORMAT(POINTER) returns format of POINTER of M.
			%  FORMAT = Element.GETPROPFORMAT(NodalMemoryCapacity, POINTER) returns format of POINTER of NodalMemoryCapacity.
			%  FORMAT = M.GETPROPFORMAT(NodalMemoryCapacity, POINTER) returns format of POINTER of NodalMemoryCapacity.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('NodalMemoryCapacity')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NodalMemoryCapacity.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nodalmemorycapacity_format_list = { 2  2  2  8  2  2  2  2  11  11  11  7  8  16  8  4  11  11  11  16  16 };
			prop_format = nodalmemorycapacity_format_list{prop};
		end
		function prop_description = getPropDescription(pointer)
			%GETPROPDESCRIPTION returns the description of a property.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(PROP) returns the
			%  description of the property PROP.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(TAG) returns the
			%  description of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DESCRIPTION = M.GETPROPDESCRIPTION(POINTER) returns description of POINTER of M.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NodalMemoryCapacity, POINTER) returns description of POINTER of NodalMemoryCapacity.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(NodalMemoryCapacity, POINTER) returns description of POINTER of NodalMemoryCapacity.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('NodalMemoryCapacity')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NodalMemoryCapacity.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nodalmemorycapacity_description_list = { 'ELCLASS (constant, string) is the class of the NodalMemoryCapacity.'  'NAME (constant, string) is the name of the NodalMemoryCapacity.'  'DESCRIPTION (constant, string) is the description of the NodalMemoryCapacity.'  'TEMPLATE (parameter, item) is the template of the NodalMemoryCapacity.'  'ID (data, string) is a few-letter code of the NodalMemoryCapacity.'  'LABEL (metadata, string) is an extended label of the NodalMemoryCapacity.'  'NOTES (metadata, string) are some specific notes about the NodalMemoryCapacity.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SHAPE (constant, scalar) is the measure shape Measure.NODAL.'  'SCOPE (constant, scalar) is the measure scope Measure.UNILAYER.'  'PARAMETRICITY (constant, scalar) is the parametricity of the measure Measure.NONPARAMETRIC.'  'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.'  'G (data, item) is the measure graph.'  'M (result, cell) is the average nodal memory capacity across all trials.'  'PFM (gui, item) contains the panel figure of the measure.'  'WAITBAR (gui, logical) determines whether to show the waitbar.'  'TRIALS (parameter, scalar) is the number of trials.'  'TRAINING_SAMPLES (parameter, scalar) is the number of training samples (length of input time series).'  'TAU_MAX (parameter, scalar) is the maximum delay to be considered.'  'MC_ALL_TRIALS (result, cell) is the nodal memory capacity at all trials.'  'MC_CALC (query, cell) calculates nodal memory capacity, given weighted connectivity matrix, input signal and maximum delay.' };
			prop_description = nodalmemorycapacity_description_list{prop};
		end
		function prop_settings = getPropSettings(pointer)
			%GETPROPSETTINGS returns the settings of a property.
			%
			% SETTINGS = Element.GETPROPSETTINGS(PROP) returns the
			%  settings of the property PROP.
			%
			% SETTINGS = Element.GETPROPSETTINGS(TAG) returns the
			%  settings of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SETTINGS = M.GETPROPSETTINGS(POINTER) returns settings of POINTER of M.
			%  SETTINGS = Element.GETPROPSETTINGS(NodalMemoryCapacity, POINTER) returns settings of POINTER of NodalMemoryCapacity.
			%  SETTINGS = M.GETPROPSETTINGS(NodalMemoryCapacity, POINTER) returns settings of POINTER of NodalMemoryCapacity.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('NodalMemoryCapacity')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NodalMemoryCapacity.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 16 % NodalMemoryCapacity.WAITBAR
					prop_settings = Format.getFormatSettings(4);
				case 17 % NodalMemoryCapacity.TRIALS
					prop_settings = Format.getFormatSettings(11);
				case 18 % NodalMemoryCapacity.TRAINING_SAMPLES
					prop_settings = Format.getFormatSettings(11);
				case 19 % NodalMemoryCapacity.TAU_MAX
					prop_settings = Format.getFormatSettings(11);
				case 20 % NodalMemoryCapacity.MC_ALL_TRIALS
					prop_settings = Format.getFormatSettings(16);
				case 21 % NodalMemoryCapacity.MC_CALC
					prop_settings = Format.getFormatSettings(16);
				case 4 % NodalMemoryCapacity.TEMPLATE
					prop_settings = 'NodalMemoryCapacity';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NodalMemoryCapacity.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NodalMemoryCapacity.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(NodalMemoryCapacity, POINTER) returns the default value of POINTER of NodalMemoryCapacity.
			%  DEFAULT = M.GETPROPDEFAULT(NodalMemoryCapacity, POINTER) returns the default value of POINTER of NodalMemoryCapacity.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('NodalMemoryCapacity')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NodalMemoryCapacity.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 16 % NodalMemoryCapacity.WAITBAR
					prop_default = true;
				case 17 % NodalMemoryCapacity.TRIALS
					prop_default = 10;
				case 18 % NodalMemoryCapacity.TRAINING_SAMPLES
					prop_default = 20000;
				case 19 % NodalMemoryCapacity.TAU_MAX
					prop_default = 35;
				case 20 % NodalMemoryCapacity.MC_ALL_TRIALS
					prop_default = Format.getFormatDefault(16, NodalMemoryCapacity.getPropSettings(prop));
				case 21 % NodalMemoryCapacity.MC_CALC
					prop_default = Format.getFormatDefault(16, NodalMemoryCapacity.getPropSettings(prop));
				case 1 % NodalMemoryCapacity.ELCLASS
					prop_default = 'NodalMemoryCapacity';
				case 2 % NodalMemoryCapacity.NAME
					prop_default = 'NodalMemoryCapacity';
				case 3 % NodalMemoryCapacity.DESCRIPTION
					prop_default = 'Nodal memory capacity is calculated using reservoir computing, which is is a recurrent neural-network model. More details about the calculation can be found at: Mijalkov et al. Computational memory capacity predicts aging and cognitive decline. (2024).';
				case 4 % NodalMemoryCapacity.TEMPLATE
					prop_default = Format.getFormatDefault(8, NodalMemoryCapacity.getPropSettings(prop));
				case 5 % NodalMemoryCapacity.ID
					prop_default = 'NodalMemoryCapacity ID';
				case 6 % NodalMemoryCapacity.LABEL
					prop_default = 'NodalMemoryCapacity label';
				case 7 % NodalMemoryCapacity.NOTES
					prop_default = 'NodalMemoryCapacity notes';
				case 9 % NodalMemoryCapacity.SHAPE
					prop_default = 2;
				case 10 % NodalMemoryCapacity.SCOPE
					prop_default = 2;
				case 11 % NodalMemoryCapacity.PARAMETRICITY
					prop_default = 2;
				case 12 % NodalMemoryCapacity.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU'};
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NodalMemoryCapacity.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NodalMemoryCapacity.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NodalMemoryCapacity, POINTER) returns the conditioned default value of POINTER of NodalMemoryCapacity.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(NodalMemoryCapacity, POINTER) returns the conditioned default value of POINTER of NodalMemoryCapacity.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('NodalMemoryCapacity')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NodalMemoryCapacity.getPropProp(pointer);
			
			prop_default = NodalMemoryCapacity.conditioning(prop, NodalMemoryCapacity.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = M.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = M.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of M.
			%  CHECK = Element.CHECKPROP(NodalMemoryCapacity, PROP, VALUE) checks VALUE format for PROP of NodalMemoryCapacity.
			%  CHECK = M.CHECKPROP(NodalMemoryCapacity, PROP, VALUE) checks VALUE format for PROP of NodalMemoryCapacity.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NodalMemoryCapacity:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: BRAPH2:NodalMemoryCapacity:WrongInput
			%  Element.CHECKPROP(NodalMemoryCapacity, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NodalMemoryCapacity.
			%   Error id: BRAPH2:NodalMemoryCapacity:WrongInput
			%  M.CHECKPROP(NodalMemoryCapacity, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NodalMemoryCapacity.
			%   Error id: BRAPH2:NodalMemoryCapacity:WrongInput]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('NodalMemoryCapacity')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NodalMemoryCapacity.getPropProp(pointer);
			
			switch prop
				case 16 % NodalMemoryCapacity.WAITBAR
					check = Format.checkFormat(4, value, NodalMemoryCapacity.getPropSettings(prop));
				case 17 % NodalMemoryCapacity.TRIALS
					check = Format.checkFormat(11, value, NodalMemoryCapacity.getPropSettings(prop));
				case 18 % NodalMemoryCapacity.TRAINING_SAMPLES
					check = Format.checkFormat(11, value, NodalMemoryCapacity.getPropSettings(prop));
				case 19 % NodalMemoryCapacity.TAU_MAX
					check = Format.checkFormat(11, value, NodalMemoryCapacity.getPropSettings(prop));
				case 20 % NodalMemoryCapacity.MC_ALL_TRIALS
					check = Format.checkFormat(16, value, NodalMemoryCapacity.getPropSettings(prop));
				case 21 % NodalMemoryCapacity.MC_CALC
					check = Format.checkFormat(16, value, NodalMemoryCapacity.getPropSettings(prop));
				case 4 % NodalMemoryCapacity.TEMPLATE
					check = Format.checkFormat(8, value, NodalMemoryCapacity.getPropSettings(prop));
				otherwise
					if prop <= 15
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NodalMemoryCapacity:' 'WrongInput'], ...
					['BRAPH2' ':NodalMemoryCapacity:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NodalMemoryCapacity.getPropTag(prop) ' (' NodalMemoryCapacity.getFormatTag(NodalMemoryCapacity.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(m, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with 5,
			%  6, and 7. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  6.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case 20 % NodalMemoryCapacity.MC_ALL_TRIALS
					rng_settings_ = rng(); rng(m.getPropSeed(20), 'twister')
					
					trials = m.get('TRIALS');
					T = m.get('TRAINING_SAMPLES');
					tau_max = m.get('TAU_MAX');
					conn_matrix = cell2mat(m.get('G').get('A'));
					N = size(conn_matrix, 1);
					
					if isequal(N, 0)
					    mc_all_trials = {};
					else
					    wb = braph2waitbar(m.get('WAITBAR'), 0, ['Calculating Memory Capacity ...']);
					    for i = 1:trials
					        input_data = rand(1, T);  % input data
					
					        % input-to-reservoir weight matrix
					        W_in = normrnd(0, 1, N, 1);
					        Wsing = svd(W_in);
					        W_in = W_in * (1 / Wsing);  % Normalize: Set maximal singular value of W_in to 1
					
					        W = conn_matrix;  % Data for the corresponding subject
					
					        % Skip matrices with NaN values
					        if ~isempty(find(isnan(W)))
					            disp('W contains NaN values, skipping..')
					            break
					        end
					
					        % Normalize reservoir weight matrix to have maximal singular value 1
					        sr = max(svd(W));
					        if sr == 0
					            disp('Sing. val. equal to zero, skipping..')
					            break
					        end
					        W = W / sr;
					
					        mc_all_trials{i} = m.get('MC_CALC', W, W_in, tau_max, input_data, 0, 0);
					
					        braph2waitbar(wb, .15 + .85 * min(i, trials) / trials, ['Memory Capacity Trial # ' num2str(min(i, trials)) ' of ' num2str(trials) ' ...'])
					    end
					    braph2waitbar(wb, 'close')
					end
					
					value = mc_all_trials;
					
					rng(rng_settings_)
					
				case 21 % NodalMemoryCapacity.MC_CALC
					if isempty(varargin)
					    value = {};
					    return
					end
					W = varargin{1};
					W_in = varargin{2};
					tau_max = varargin{3};
					input_data = varargin{4};
					ridge = varargin{5};
					verbose = varargin{6};
					
					N = size(W, 1);  % Network dimension
					T = size(input_data, 2);  % Training samples
					TRANSIENT = floor(0.05 * T);  % Transient so that reservoir dynamics are not affected by initial value
					
					% Initialize training data
					X = input_data;
					X_train = X(1, tau_max + 1:end); % Train reservoir on data starting from tau_max + 1
					T_train = size(X_train, 2);
					
					% Initialize reservoir states
					r = zeros(N, 1);
					R = zeros(N, T_train);
					
					% Run dynamics
					for t = 1:1:T_train
					    b = W * r + W_in * X_train(t);
					
					    r = tanh(b);
					    R(:,t) = r;
					end
					
					% Train network for different delays
					MC_tau = zeros(tau_max, N);  % Initialize MC_tau: no delays x no of nodes
					tau_idx = 1;
					for tau = tau_max:-1:1
					    % Set target to be training data shifted by tau back in time
					    y = X(1, tau : 1 : (T - (tau_max - tau) - 1));
					
					    % Remove transient
					    y_f = y(1, TRANSIENT:1:end);
					    R_tmp = R(:, TRANSIENT:1:end);
					
					    % Consider each node
					    for i_node = 1:1:N
					        % output corresponding to this node
					        R_f = R_tmp(i_node, :);
					
					        % Compute W_out for given delay tau using ridge regression (linear regression if ridge = 0)
					        term_A = y_f * R_f';
					        term_B = pinv(R_f * R_f', 1e-15);  % remove the rigde term for nodal
					        W_out = term_A * term_B;
					
					        % Compute output of reservoir using W_out
					        y_pred = W_out * R_f;
					
					        % Compute correlation between output and delayed input
					        MC_tau(tau_idx, i_node) = corr(y_f', y_pred');
					    end
					
					    if verbose
					        disp(['MC (τ = ' num2str(tau_idx) ') = ' num2str(MC_tau(tau_idx))])
					    end
					    tau_idx = tau_idx + 1;
					end
					
					value = MC_tau;
					
				case 14 % NodalMemoryCapacity.M
					rng_settings_ = rng(); rng(m.getPropSeed(14), 'twister')
					
					mc_all_trials = m.get('MC_ALL_TRIALS');
					if isempty(mc_all_trials)
					    m_value = {};
					else
					    summed_mc_all_trials = cellfun(@(mc_all_delays) sum(mc_all_delays, 1), mc_all_trials, 'UniformOutput', false);
                        % Convert the cell array 'summed_mc_all_trials' to a matrix, compute the mean across rows,
                        %  and store the result as a column vector in a cell.
                        %  The double transpose ensures the output for each cell is a column vector (e.g., 68x1 for degree).
                        m_value = {mean(cell2mat(summed_mc_all_trials'))'};
					end
					value = m_value;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 15
						value = calculateValue@Measure(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
