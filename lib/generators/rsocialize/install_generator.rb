require 'rails/generators'
module Rsocialize
  class InstallGenerator < Rails::Generators::Base
    #rails g rsocialize:install example1
    argument :css_layout_name, :type => :string, :default => "example1"  
    def self.source_root
      @_rsocialize_root ||= File.expand_path("../templates", __FILE__)
    end
    def create_layout
      copy_file 'example1.css', 'app/assets/stylesheets/example1css.txt'
      copy_file 'example2.css', 'app/assets/stylesheets/example2css.txt'
      copy_file 'example3.css', 'app/assets/stylesheets/example3css.txt'
      copy_file 'example5.css', 'app/assets/stylesheets/example5css.txt'
      copy_file 'example6.css', 'app/assets/stylesheets/example6css.txt'
      copy_file 'rsocialize.css', 'app/assets/stylesheets/rsocialize.css'
      copy_file %Q{#{Rsocialize::JQUERY_SHARRRE_FILE}}, %Q{app/assets/javascripts/#{Rsocialize::JQUERY_SHARRRE_FILE}}
      copy_file 'rsocialize_controller.rb', 'app/lib/rsocialize_controller.rb'
      directory 'images', 'app/assets/images'
    end
    def modify_css
      css_path = "app/assets/stylesheets/"+"#{css_layout_name}css.txt"
      css_str = IO.read(css_path)
      rs_filename = %Q{app/assets/stylesheets/rsocialize.css}
      File.open(rs_filename, 'w') {|f| f.write(css_str) }
    end
    def modify_routes
      line = "::Application.routes.draw do"
      gsub_file 'config/routes.rb', /(#{Regexp.escape(line)})/mi do |match|
        %Q{#{match}\n  match '/sharrre' => 'rsocialize#sharrre'}
      end
    end
  end #end class InstallGenerator 
end #Rsocialize
