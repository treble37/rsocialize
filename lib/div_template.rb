class DivTemplate
  attr_accessor :options

  def initialize(opts={})
    @options = {}
    @options.merge!(opts)
  end

end

class Example1 < DivTemplate
  def div_str
      %Q{
        <div id="example1">
          <div id="twitter" data-url="#{options[:twitter][:url]}" data-text="#{options[:twitter][:text]}" data-title="#{options[:twitter][:title]}"></div>
          <div id="facebook" data-url="#{options[:facebook][:url]}" data-text="#{options[:facebook][:text]}" data-title="#{options[:facebook][:title]}"></div>
          <div id="googleplus" data-url="#{options[:googleplus][:url]}" data-text="#{options[:googleplus][:text]}" data-title="#{options[:googleplus][:title]}"></div>
      </div>
      }.html_safe
  end
end

[2, 5].each do |i|
  klass = Object.const_set("Example#{i}", Class.new(DivTemplate))
  klass.send(:define_method, "div_str") do |*args|
    %Q{
      <div id="#{options[:div_template]}">
        <div id="shareme" data-url="#{options[:url]}" data-text="#{options[:text]}"></div>
      </div>
    }.html_safe
  end
end

class Example3 < DivTemplate
  def div_str
    %Q{
      <div id="example3">
        <div id="shareme" data-url="#{options[:url]}" data-text="#{options[:text]}" data-title="#{options[:title]}"></div>
      </div>
    }.html_safe
  end
end

class Example6 < DivTemplate
  def div_str
    %Q{
      <div id="example6">
        <div id="twitter" data-url="#{options[:twitter][:url]}" data-text="#{options[:twitter][:text]}"></div>
        <div id="facebook" data-url="#{options[:facebook][:url]}" data-text="#{options[:facebook][:text]}"></div>
        <div id="googleplus" data-url="#{options[:googleplus][:url]}" data-text="#{options[:googleplus][:text]}"></div>
    </div>
    }.html_safe
  end
end
