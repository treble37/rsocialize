require "rsocialize/version"
require "action_view"
require 'div_template'
require 'example_options'

module Rsocialize
  require 'rsocialize/engine' if defined?(Rails)
  JQUERY_SHARRRE_FILE = "jquery.sharrre-1.3.5.min.js"

  def rsocialize_div_tag(div_tag_str="", options={})
    #options{} :=
     # url: http://www.example.com/
      # text: text for tweeting, facebook, etc.
    options = {:facebook=>{:url=>"http://sharrre.com/", :text=>"Make your sharing widget with Sharrre (jQuery Plugin)", :title=>"Like"},
      :googleplus=>{:url=>"http://sharrre.com/", :text=>"Make your sharing widget with Sharrre (jQuery Plugin)", :title=>"+1"},
      :twitter=>{:url=>"http://sharrre.com/", :text=>"Make your sharing widget with Sharrre (jQuery Plugin)", :title=>"Tweet"},
     :div_template=>"example1", :url=>"http://sharrre.com/", :text=>"Make your sharing widget with Sharrre (jQuery Plugin)", :title=>"share this page"}.merge(options)
  
    div_str = if !(options[:div_template]=~/example[12356]/).nil?
      klass = options[:div_template].slice(0,1).capitalize + options[:div_template].slice(1..-1)
      klass.constantize.new(options).div_str
    elsif div_tag_str.empty?  #assume empty or custom
       #use template <div>
      %Q{
        <div id="#{options[:div_template]}">
          <div id="twitter" data-url="#{options[:url]}" data-text="#{options[:text]}" data-title="Tweet"></div>
          <div id="facebook" data-url="#{options[:url]}" data-text="#{options[:text]}" data-title="Like"></div>
          <div id="googleplus" data-url="#{options[:url]}" data-text="#{options[:text]}" data-title="+1"></div>
       </div> 
     }.html_safe
    else  #use your own <div> classes
      div_tag_str.html_safe
    end
    
    return div_str
  end

  def rsocialize_js_tag(options={})
    options = Object.const_get(options[:js_template].upcase + "_JS_OPTIONS") if options[:js_template]=~/example\d{1}/
    options=options.merge(options)
    
    js_str = "<script>\n".html_safe
    js_str = js_str + rsocialize_build_js(options).html_safe
    js_str += "</script>".html_safe
    return js_str
  end

  def rsocialize_build_js(options={})
    @debug_str = ""
    @js_str = "$(document).ready(function() { "
    options.each_key do |key|
      @js_str = @js_str + 
          "$('##{key.to_s.downcase}').sharrre({\n"
          options[key].each_key do |key2|
            @js_str = @js_str+%Q{ #{recursive_js_build(options[key],key2, key.to_s)} }
            @js_str = @js_str+"\n"
          end     
        @js_str = @js_str+"});\n" 
    end #options.each_key do |key|
    @js_str = @js_str + "});" 
    return @js_str
  end

  def recursive_js_build(options, key, button_val) 
    @retval=%Q{#{key.to_s}: }
    @retval = @retval+"{" if hash_depth(options[key])>0
    if options[key].is_a?(Hash)
      options[key].each_key do |nested_key|
        @retval = @retval + %Q{ #{recursive_js_build(options[key],nested_key,button_val)} }
      end
    else
      new_key = options[key]
      if !(options[key]==true||options[key]==false)
        new_key = %Q{'#{options[key]}'} if (options[key][0,1])!~/[\$f]/
        #Regexp and mapping to sharrre jQuery options
        #$ = start of jquery 
        #f = start of function call
      end
      @retval = @retval + %Q{#{new_key}}
      @retval = @retval+"," if options.length>1 && options.keys.last!=key
    end
    if hash_depth(options[key])>0 && options.keys.last!=key
      @retval = @retval + "},\n" 
    elsif hash_depth(options[key])>0
      @retval = @retval + "}\n"
    end
    return @retval
  end

  def hash_depth(bhash)
    #return depth of hash as an integer
    return 0 if !bhash.is_a?(Hash) #no hash = 0
    if bhash[bhash.keys.first].is_a?(Hash) #could be nil if hash is only one level deep
      @depth = hash_depth(bhash[bhash.keys.first])+1 
    else #so return 1
      return 1
    end
    @depth
  end
end #end module Rsocialize

class ActionView::Base # :nodoc:
  include Rsocialize
end
