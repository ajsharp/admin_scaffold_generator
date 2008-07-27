require 'rails_generator/generators/components/controller/controller_generator'

class AdminScaffoldGenerator < ControllerGenerator
  attr_reader   :controller_name,
                :controller_class_path,
                :controller_file_path,
                :controller_class_nesting,
                :controller_class_nesting_depth,
                :controller_class_name,
                :controller_underscore_name,
                :controller_singular_name,
                :controller_plural_name,
                :controller_class_name_without_nesting
  alias_method  :controller_file_name,  :controller_underscore_name
  alias_method  :controller_table_name, :controller_plural_name
  
  def initialize(runtime_args, runtime_options = {})
    super
    
    @controller_name = @name.pluralize
    
    base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(@controller_name)
    
    @controller_class_name_without_nesting, @controller_underscore_name, @controller_plural_name = inflect_names(base_name)
    
    @controller_singular_name=base_name.singularize
    
    if @controller_class_nesting.empty?
      @controller_class_name = @controller_class_name_without_nesting
    else
      @controller_class_name = "#{@controller_class_nesting}::#{@controller_class_name_without_nesting}"
    end
  end
  
  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions(class_path, "#{class_name}Controller", "#{class_name}Helper")
      
      # Controller, helper, views, and spec directories.
      m.directory File.join('app/controllers', class_path)
      m.directory File.join('app/helpers', class_path)
      m.directory File.join('app/views', class_path, file_name)
      m.directory File.join('spec/controllers', class_path)
      m.directory File.join('spec/helpers', class_path)
      m.directory File.join('spec/views', class_path, file_name)
      
      # Controller spec, class, and helper.       
      m.template 'rspec_controller:controller_spec.rb',
        File.join('spec/controllers', class_path, "#{file_name}_controller_spec.rb")
        
      m.template 'rspec_controller:helper_spec.rb',
       File.join('spec/helpers', class_path, "#{file_name}_helper_spec.rb")
      
      m.template 'controller.rb', 
        File.join('app/controllers', class_path, "#{file_name}_controller.rb")

      m.template "controller:helper.rb",
       File.join('app/helpers', class_path, "#{file_name}_helper.rb")
       
      @default_file_extension = "html.erb"
      # Spec and view template for each action.
      actions.each do |action|
       path = File.join('app/views', class_path, file_name, "#{action}.#{@default_file_extension}")
       m.template "controller:view.#{@default_file_extension}",
         path,
         :assigns => { :action => action, :path => path }
      end
    end
  end
end
