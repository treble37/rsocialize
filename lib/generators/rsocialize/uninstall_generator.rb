require 'rails/generators'
module Rsocialize
  class UninstallGenerator < Rails::Generators::Base
    #rails g rsocialize:uninstall
    def self.source_root
      @_rsocialize_root ||= File.expand_path("../templates", __FILE__)
    end
    def destroy_layout
      remove_file 'app/assets/stylesheets/example1css.txt'
      remove_file 'app/assets/stylesheets/example2css.txt'
      remove_file 'app/assets/stylesheets/example3css.txt'
      remove_file 'app/assets/stylesheets/example5css.txt'
      remove_file 'app/assets/stylesheets/example6css.txt'
      remove_file 'app/assets/stylesheets/rsocialize.css'
      remove_file %Q{app/assets/javascripts/#{Rsocialize::JQUERY_SHARRRE_FILE}}
      remove_file 'app/lib/rsocialize_controller.rb'
      remove_file 'app/assets/images'
    end
    def unmodify_routes
      line = %Q{match '/sharrre' => 'Rsocialize#sharrre'}
      gsub_file 'config/routes.rb', /(#{Regexp.escape(line)})/mi,''
    end
  end #class UninstallGenerator
end