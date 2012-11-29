require 'rails/generators'
module Rsocialize
  class SwitchCssGenerator < Rails::Generators::Base
    #rails g rsocialize:install example1
    argument :css_layout_name, :type => :string, :default => "example1"  
    def self.source_root
      @_rsocialize_root ||= File.expand_path("../templates", __FILE__)
    end
    def modify_css
      css_path = "app/assets/stylesheets/"+"#{css_layout_name}css.txt"
      css_str = IO.read(css_path)
      rs_filename = %Q{app/assets/stylesheets/rsocialize.css}
      File.open(rs_filename, 'w') {|f| f.write(css_str) }
      puts "Status: #{css_layout_name} style applied"
    end
  end #end class SwitchCssGenerator 
end #Rsocialize
