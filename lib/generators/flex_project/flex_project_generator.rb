class FlexProjectGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :flex_name, :type =>:string
  #argument :flex_main, :type =>:string, :default=>"main"
  # Can't make the main file optional
  #class_option :generate_main, :type => :boolean, :default=>true

  def generate_tasks
    template "flex_tasks.rake", "lib/tasks/flex_tasks.rake"
  end
  def generate_projects
    empty_directory "flex/bin"
    copy_file "lib_readme", "flex/lib/readme"
    template "main.mxml.erb", "flex/src/#{file_name}.mxml"
  end

  private
  def file_name
    flex_name.underscore
  end
end
