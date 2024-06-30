classdef NodalMemoryCapacity < Measure
	%NodalMemoryCapacity is the graph NodalMemoryCapacity.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% Fix this Mite
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
		TRIALS = Measure.getPropNumber() + 1;
		TRIALS_TAG = 'TRIALS';
		TRIALS_CATEGORY = Category.PARAMETER;
		TRIALS_FORMAT = Format.SCALAR;
		
		TRAINING_SAMPLES = Measure.getPropNumber() + 2;
		TRAINING_SAMPLES_TAG = 'TRAINING_SAMPLES';
		TRAINING_SAMPLES_CATEGORY = Category.PARAMETER;
		TRAINING_SAMPLES_FORMAT = Format.SCALAR;
		
		TAU_MAX = Measure.getPropNumber() + 3;
		TAU_MAX_TAG = 'TAU_MAX';
		TAU_MAX_CATEGORY = Category.PARAMETER;
		TAU_MAX_FORMAT = Format.SCALAR;
		
		N_LOWER = Measure.getPropNumber() + 4;
		N_LOWER_TAG = 'N_LOWER';
		N_LOWER_CATEGORY = Category.PARAMETER;
		N_LOWER_FORMAT = Format.SCALAR;
		
		DENSITY = Measure.getPropNumber() + 5;
		DENSITY_TAG = 'DENSITY';
		DENSITY_CATEGORY = Category.PARAMETER;
		DENSITY_FORMAT = Format.SCALAR;
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
			%
			% See also Category, Format.
			
			m = m@Measure(varargin{:});
		end
	end
	methods (Static) % inspection
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
			
			subclass_list = subclasses('NodalMemoryCapacity', [], [], true);
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
			
			if nargin == 0
				prop_list = [ ...
					Measure.getProps() ...
						NodalMemoryCapacity.TRIALS ...
						NodalMemoryCapacity.TRAINING_SAMPLES ...
						NodalMemoryCapacity.TAU_MAX ...
						NodalMemoryCapacity.N_LOWER ...
						NodalMemoryCapacity.DENSITY ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Measure.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Measure.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Measure.getProps(Category.PARAMETER) ...
						NodalMemoryCapacity.TRIALS ...
						NodalMemoryCapacity.TRAINING_SAMPLES ...
						NodalMemoryCapacity.TAU_MAX ...
						NodalMemoryCapacity.N_LOWER ...
						NodalMemoryCapacity.DENSITY ...
						];
				case Category.DATA
					prop_list = [ ...
						Measure.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						Measure.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Measure.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Measure.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Measure.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Measure.getProps(Category.GUI) ...
						];
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
			
			prop_number = numel(NodalMemoryCapacity.getProps(varargin{:}));
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
			
			check = any(prop == NodalMemoryCapacity.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NodalMemoryCapacity:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NodalMemoryCapacity:' BRAPH2.WRONG_INPUT '\n' ...
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
			
			nodalmemorycapacity_tag_list = cellfun(@(x) NodalMemoryCapacity.getPropTag(x), num2cell(NodalMemoryCapacity.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nodalmemorycapacity_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NodalMemoryCapacity:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NodalMemoryCapacity:' BRAPH2.WRONG_INPUT '\n' ...
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
				nodalmemorycapacity_tag_list = cellfun(@(x) NodalMemoryCapacity.getPropTag(x), num2cell(NodalMemoryCapacity.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nodalmemorycapacity_tag_list)); % tag = pointer
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
				prop = pointer;
				
				switch prop
					case NodalMemoryCapacity.TRIALS
						tag = NodalMemoryCapacity.TRIALS_TAG;
					case NodalMemoryCapacity.TRAINING_SAMPLES
						tag = NodalMemoryCapacity.TRAINING_SAMPLES_TAG;
					case NodalMemoryCapacity.TAU_MAX
						tag = NodalMemoryCapacity.TAU_MAX_TAG;
					case NodalMemoryCapacity.N_LOWER
						tag = NodalMemoryCapacity.N_LOWER_TAG;
					case NodalMemoryCapacity.DENSITY
						tag = NodalMemoryCapacity.DENSITY_TAG;
					otherwise
						tag = getPropTag@Measure(prop);
				end
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
			
			switch prop
				case NodalMemoryCapacity.TRIALS
					prop_category = NodalMemoryCapacity.TRIALS_CATEGORY;
				case NodalMemoryCapacity.TRAINING_SAMPLES
					prop_category = NodalMemoryCapacity.TRAINING_SAMPLES_CATEGORY;
				case NodalMemoryCapacity.TAU_MAX
					prop_category = NodalMemoryCapacity.TAU_MAX_CATEGORY;
				case NodalMemoryCapacity.N_LOWER
					prop_category = NodalMemoryCapacity.N_LOWER_CATEGORY;
				case NodalMemoryCapacity.DENSITY
					prop_category = NodalMemoryCapacity.DENSITY_CATEGORY;
				otherwise
					prop_category = getPropCategory@Measure(prop);
			end
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
			
			switch prop
				case NodalMemoryCapacity.TRIALS
					prop_format = NodalMemoryCapacity.TRIALS_FORMAT;
				case NodalMemoryCapacity.TRAINING_SAMPLES
					prop_format = NodalMemoryCapacity.TRAINING_SAMPLES_FORMAT;
				case NodalMemoryCapacity.TAU_MAX
					prop_format = NodalMemoryCapacity.TAU_MAX_FORMAT;
				case NodalMemoryCapacity.N_LOWER
					prop_format = NodalMemoryCapacity.N_LOWER_FORMAT;
				case NodalMemoryCapacity.DENSITY
					prop_format = NodalMemoryCapacity.DENSITY_FORMAT;
				otherwise
					prop_format = getPropFormat@Measure(prop);
			end
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
			
			switch prop
				case NodalMemoryCapacity.TRIALS
					prop_description = 'TRIALS (parameter, scalar) is the number of trials.';
				case NodalMemoryCapacity.TRAINING_SAMPLES
					prop_description = 'TRAINING_SAMPLES (parameter, scalar) is the number of training samples.';
				case NodalMemoryCapacity.TAU_MAX
					prop_description = 'TAU_MAX (parameter, scalar) is the number of tau.';
				case NodalMemoryCapacity.N_LOWER
					prop_description = 'N_LOWER (parameter, scalar) is the n lower.';
				case NodalMemoryCapacity.DENSITY
					prop_description = 'DENSITY (parameter, scalar) is the density.';
				case NodalMemoryCapacity.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the NodalMemoryCapacity.';
				case NodalMemoryCapacity.NAME
					prop_description = 'NAME (constant, string) is the name of the NodalMemoryCapacity.';
				case NodalMemoryCapacity.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the NodalMemoryCapacity.';
				case NodalMemoryCapacity.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the NodalMemoryCapacity.';
				case NodalMemoryCapacity.ID
					prop_description = 'ID (data, string) is a few-letter code of the NodalMemoryCapacity.';
				case NodalMemoryCapacity.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the NodalMemoryCapacity.';
				case NodalMemoryCapacity.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the NodalMemoryCapacity.';
				case NodalMemoryCapacity.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case NodalMemoryCapacity.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case NodalMemoryCapacity.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case NodalMemoryCapacity.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case NodalMemoryCapacity.M
					prop_description = 'M (result, cell) is the NodalMemoryCapacity.';
				otherwise
					prop_description = getPropDescription@Measure(prop);
			end
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
			
			switch prop
				case NodalMemoryCapacity.TRIALS
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NodalMemoryCapacity.TRAINING_SAMPLES
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NodalMemoryCapacity.TAU_MAX
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NodalMemoryCapacity.N_LOWER
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NodalMemoryCapacity.DENSITY
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case NodalMemoryCapacity.TEMPLATE
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
			
			switch prop
				case NodalMemoryCapacity.TRIALS
					prop_default = 10;
				case NodalMemoryCapacity.TRAINING_SAMPLES
					prop_default = 20000;
				case NodalMemoryCapacity.TAU_MAX
					prop_default = 50;
				case NodalMemoryCapacity.N_LOWER
					prop_default = 1;
				case NodalMemoryCapacity.DENSITY
					prop_default = 1;
				case NodalMemoryCapacity.ELCLASS
					prop_default = 'NodalMemoryCapacity';
				case NodalMemoryCapacity.NAME
					prop_default = 'NodalMemoryCapacity';
				case NodalMemoryCapacity.DESCRIPTION
					prop_default = 'Fix this Mite';
				case NodalMemoryCapacity.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NodalMemoryCapacity.getPropSettings(prop));
				case NodalMemoryCapacity.ID
					prop_default = 'NodalMemoryCapacity ID';
				case NodalMemoryCapacity.LABEL
					prop_default = 'NodalMemoryCapacity label';
				case NodalMemoryCapacity.NOTES
					prop_default = 'NodalMemoryCapacity notes';
				case NodalMemoryCapacity.SHAPE
					prop_default = Measure.NODAL;
				case NodalMemoryCapacity.SCOPE
					prop_default = Measure.UNILAYER;
				case NodalMemoryCapacity.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case NodalMemoryCapacity.COMPATIBLE_GRAPHS
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
			%  Error id: €BRAPH2.STR€:NodalMemoryCapacity:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:NodalMemoryCapacity:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NodalMemoryCapacity, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NodalMemoryCapacity.
			%   Error id: €BRAPH2.STR€:NodalMemoryCapacity:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(NodalMemoryCapacity, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NodalMemoryCapacity.
			%   Error id: €BRAPH2.STR€:NodalMemoryCapacity:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('NodalMemoryCapacity')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NodalMemoryCapacity.getPropProp(pointer);
			
			switch prop
				case NodalMemoryCapacity.TRIALS % __NodalMemoryCapacity.TRIALS__
					check = Format.checkFormat(Format.SCALAR, value, NodalMemoryCapacity.getPropSettings(prop));
				case NodalMemoryCapacity.TRAINING_SAMPLES % __NodalMemoryCapacity.TRAINING_SAMPLES__
					check = Format.checkFormat(Format.SCALAR, value, NodalMemoryCapacity.getPropSettings(prop));
				case NodalMemoryCapacity.TAU_MAX % __NodalMemoryCapacity.TAU_MAX__
					check = Format.checkFormat(Format.SCALAR, value, NodalMemoryCapacity.getPropSettings(prop));
				case NodalMemoryCapacity.N_LOWER % __NodalMemoryCapacity.N_LOWER__
					check = Format.checkFormat(Format.SCALAR, value, NodalMemoryCapacity.getPropSettings(prop));
				case NodalMemoryCapacity.DENSITY % __NodalMemoryCapacity.DENSITY__
					check = Format.checkFormat(Format.SCALAR, value, NodalMemoryCapacity.getPropSettings(prop));
				case NodalMemoryCapacity.TEMPLATE % __NodalMemoryCapacity.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NodalMemoryCapacity.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NodalMemoryCapacity:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NodalMemoryCapacity:' BRAPH2.WRONG_INPUT '\n' ...
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
			%  PROP. It works only with properties with Category.RESULT,
			%  Category.QUERY, and Category.EVANESCENT. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  Category.QUERY.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case NodalMemoryCapacity.M % __NodalMemoryCapacity.M__
					rng_settings_ = rng(); rng(m.getPropSeed(NodalMemoryCapacity.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					tmp_data = g.get('A'); % cell with the subjects data
					if isempty(tmp_data)
					    value = {};
					    return;
					end
					for i = 1:size(tmp_data, 1)
					    data{i} = tmp_data{i, i};
					end
					global_mc = cell(g.get('LAYERNUMBER'), 1);
					
					% parameters
					trials = m.get('TRIALS');
					T = m.get('TRAINING_SAMPLES');
					tau_max = m.get('TAU_MAX');
					
					N = size(data{1}, 1);
					n = m.get('N_LOWER');
					density = m.get('DENSITY');
					
					% initialize
					% Number of subjects
					subjects = size(data, 2);
					% Initialize structure - each element holds data for each trial
					data_alltrial_MCs = cell(1, trials);
					
					for trial = 1:1:trials
					    % input data
					    input_data = rand(1, T);
					
					    % input-to-reservoir weight matrix
					    W_in = normrnd(0, 1, N, n);
					    Wsing = svd(W_in);
					    W_in = W_in * (1 / Wsing); % Set maximal singular value of W_in to 1
					
					    % Initialize array to hold tau values for all subjects for this trial
					    MCs_tau_sub = zeros(tau_max, N, subjects);
					
					    for subject = 1:1:subjects
					        % Get the data for the corresponding subject
					        W = data{1, subject};
					
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
					
					        % Compute memory capacity
					        MC_tau = calculate_MCnodal(W, W_in, tau_max, input_data, 0, 0);
					
					        % Store memory capacity for each subject
					        MCs_tau_sub(:, :, subject) = MC_tau;
					
					    end
					
					    % Place the values into the array
					    data_alltrial_MCs{1, trial} = MCs_tau_sub;
					end
					
					% split
					for i = 1:size(data, 2)
					    tmp_layer_val{i} = cellfun(@(x) x(:,:,i), data_alltrial_MCs, 'UniformOutput',false);
					end
					
					% average
					for i = 1:size(data, 2)
					    tmp_trials = tmp_layer_val{i};
					    mean_val_layer{i} =  mean(cat(ndims(tmp_trials{1}) + 1, tmp_trials{:}), ndims(tmp_trials{1}) + 1);
					end
					
					value = mean_val_layer;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Measure.getPropNumber()
						value = calculateValue@Measure(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
			function MC_tau = calculate_MCnodal(W,W_in,tau_max,input_data, ridge,verbose)
			    % Network dimension
			    N = size(W, 1);
			    
			    % Parameters
			    T = size(input_data, 2); % Training samples
			    TRANSIENT = floor(0.05 * T); % Transient so that reservoir dynamics are not affected by initial value
			    
			    % Initialize training data
			    X = input_data;
			    X_train = X(1, tau_max + 1:end); % Train reservoir on data starting from tau_max + 1
			    T_train = size(X_train, 2);
			    
			    % Set activation function
			    % tanh
			    
			    % Initialize reservoir states
			    r = zeros(N, 1);
			    R = zeros(N, T_train);
			    
			    % Run dynamics and save reservoir states
			    for t = 1:1:T_train
			        b = W * r + W_in * X_train(t);
			    
			        r = tanh(b);
			        R(:,t) = r;
			    end
			    
			    % Train network for different delays
			    % MC_tau will be number of delays x number of nodes array
			    MC_tau = zeros(tau_max, N);
			    tau_idx = 1;
			    
			    % for loop to come here
			    for tau = tau_max:-1:1
			        % Set target to be training data shifted by tau back in time
			        y = X(1, tau : 1 : (T - (tau_max - tau) - 1));
			    
			        % Remove transient
			        y_f = y(1, TRANSIENT:1:end);
			        R_tmp = R(:, TRANSIENT:1:end);
			    
			        % Loop over each node and get the output from that node to reconstruct
			        for i_node = 1:1:N
			            % output corresponding to this node
			            R_f = R_tmp(i_node, :);
			    
			            % Compute W_out for given delay tau using
			            % ridge regression (linear regression if ridge = 0)
			            term_A = y_f * R_f';
			            term_B = pinv(R_f * R_f', 1e-15); % remove the rigde term for nodal
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
			end
		end
	end
end
