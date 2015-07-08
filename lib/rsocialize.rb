require "rsocialize/version"
require "action_view"
require 'div_template'
module Rsocialize
  require 'rsocialize/engine' if defined?(Rails)
  JQUERY_SHARRRE_FILE = "jquery.sharrre-1.3.5.min.js"
  EXAMPLE1_JS_OPTIONS = {
    :twitter=>{:share=>{:twitter=>true},:enableHover=>false, :enableTracking=>true, :buttons=>{:twitter=>{:via=>'_JulienH'}},:click=>%Q[function(api, options){
    api.simulateClick();
    api.openPopup('twitter');}  ]
    }, 
    :facebook=>{:share=>{:facebook=>true}, :enableHover=>false, :enableTracking=>true, :click=>%Q[function(api, options){
    api.simulateClick();
    api.openPopup('facebook');}
    ]
    }, 
    :googlePlus=>{:share=>{:googlePlus=>true},:enableHover=>false, :enableTracking=>true, :click=>%Q[function(api, options){
    api.simulateClick();
    api.openPopup('googlePlus');} ]
    }
  }
  EXAMPLE2_JS_OPTIONS = {
    shareme: {
      share: {
        twitter: true,
        facebook: true,
        googlePlus: true
      },
  template: %Q{<div class="box"><div class="left">Share</div><div class="middle"><a href="#" class="facebook">f</a><a href="#" class="twitter">t</a><a href="#" class="googleplus">+1</a></div><div class="right">{total}</div></div>},
  enableHover: false,
  enableTracking: true,
  render: %Q[function(api, options){
        $(api.element).on('click', '.twitter', function() {
          api.openPopup('twitter');
        });
        $(api.element).on('click', '.facebook', function() {
          api.openPopup('facebook');
        });
        $(api.element).on('click', '.googleplus', function() {
          api.openPopup('googlePlus');
        });
      }]
    }
  }
  EXAMPLE3_JS_OPTIONS = {
    shareme: {
      share: {
        googlePlus: true,
        facebook: true,
        twitter: true,
        digg: true,
        delicious: true
      },
      enableTracking: true,
      buttons: {
        googlePlus: {size: 'tall'},
        facebook: {layout: 'box_count'},
        twitter: {count: 'vertical'},
        digg: {type: 'DiggMedium'},
        delicious: {size: 'tall'}
      },
      hover: %Q[function(api, options){
        $(api.element).find('.buttons').show();
      }],
      hide: %Q[function(api, options){
        $(api.element).find('.buttons').hide();
      }]
    }
  }
  EXAMPLE5_JS_OPTIONS = {
    shareme: {
      share: {
        googlePlus: true, 
        facebook: true,
        twitter: true,
        digg: true,
        delicious: true,
        stumbleupon: true,
        linkedin: true,
        pinterest: true
      },
      buttons: {
        googlePlus: {size: 'tall'},
        facebook: {layout: 'box_count'},
        twitter: {count: 'vertical'},
        digg: {type: 'DiggMedium'},
        delicious: {size: 'tall'},
        stumbleupon: {layout: '5'},
        linkedin: {counter: 'top'},
        pinterest: {media: 'http://sharrre.com/img/example1.png', description: %Q{$('#shareme').data('text'), layout: 'vertical'}}
        },
        enableHover: false,
        enableCounter: false,
        enableTracking: true
      }
  }
  
  EXAMPLE6_JS_OPTIONS ={
  :twitter=>{:share=>{:twitter=>true},:template=>%Q{<a class="box" href="#"><div class="count" href="#">{total}</div><div class="share"><span></span>Tweet</div></a>},  :enableHover=>false, :enableTracking=>true, :buttons =>{ twitter: {via: '_JulienH'}}, :click=>%Q[function(api, options){
    api.simulateClick();
    api.openPopup('twitter');}
    ]
  }, 
  :facebook=> {:share=>{:facebook=>true},:template=>%Q{<a class="box" href="#"><div class="count" href="#">{total}</div><div class="share"><span></span>Like</div></a>}, :enableHover=>false, :enableTracking=>true, :click=>%Q[function(api, options){
    api.simulateClick();
    api.openPopup('facebook');}
    ] 
  }, 
  :googlePlus=>{:share=>{:googlePlus=>true},:template=>%Q{<a class="box" href="#"><div class="count" href="#">{total}</div><div class="share"><span></span>+1</div></a>}, :enableHover=>false, :enableTracking=>true, :click=>%Q[function(api, options){
    api.simulateClick();
    api.openPopup('googlePlus');}
    ]
  } 
}
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
    case options[:js_template]
    when "example1"
      options = EXAMPLE1_JS_OPTIONS
    when "example2"
      options = EXAMPLE2_JS_OPTIONS
    when "example3"
      options = EXAMPLE3_JS_OPTIONS
    when "example5"
      options = EXAMPLE5_JS_OPTIONS
    when "example6"
      options = EXAMPLE6_JS_OPTIONS
    end
    options=options.merge(options)
    
    js_str = "<script>\n".html_safe
    js_str = js_str+rsocialize_build_js(options).html_safe
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
