class FlexProjectGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :flex_name, :type =>:string
  class_option :generate_public_pages, :type => :boolean, :default=>true
  #argument :flex_main, :type =>:string, :default=>"main"
  # Can't make the main file optional
  #class_option :generate_main, :type => :boolean, :default=>true


  # Gnerate method to execute the steps involved in creating a flex project
  def generate
    generate_tasks
    generate_project
    generate_public if options.generate_public_pages?
  end

  private
  # Generate rake tasks to build flex from the command line
  def generate_tasks
    template "flex_tasks.rake", "lib/tasks/flex_tasks.rake"
  end

  # Generate a flex work error inside this rails project
  def generate_project
    empty_directory "flex/bin"
    copy_file "lib_readme", "flex/lib/readme"
    template "main.mxml.erb", "flex/src/#{file_name}.mxml"
  end

  # Create the public files for an application
  def generate_public
    copy_file "swfobject/swfobject.js", "public/javascripts/swfobject.js"
    copy_file "swfobject/expressInstall.swf", "public/expressInstall.swf"
    template "swfobject/index_dynamic.html.erb", "public/#{file_name}.html"
  end
  # setup the file name from the given project name
  def file_name
    flex_name.underscore
  end
end
