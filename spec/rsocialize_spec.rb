require 'spec_helper'
describe "rsocialize" do
  class DummyClass
    include Rsocialize
  end
  context "with EXAMPLE1_OPTIONS" do
    before(:each) do
      @dumb_class = DummyClass.new
      @js_code_example1 = %Q[<script>
$(document).ready(function() { $('#twitter').sharrre({
  share: { twitter: true },
  
  enableHover: false,
  enableTracking: true,
  buttons: { twitter: {via: '_JulienH'}
  },
  
  click: function(api, options){
    api.simulateClick();
    api.openPopup('twitter');}
});
$('#facebook').sharrre({
  share: { facebook: true },
  
  enableHover: false,
  enableTracking: true,
  click: function(api, options){
    api.simulateClick();
    api.openPopup('facebook');}
    
});
$('#googleplus').sharrre({
  share: { googlePlus: true },
  
  enableHover: false,
  enableTracking: true,
  click: function(api, options){
    api.simulateClick();
    api.openPopup('googlePlus');}
});
});
</script>]
    @div_example1=%Q{
      <div id="example1">
        <div id="twitter" data-url="http://sharrre.com/" data-text="Make your sharing widget with Sharrre (jQuery Plugin)" data-title="Tweet"></div>
        <div id="facebook" data-url="http://sharrre.com/" data-text="Make your sharing widget with Sharrre (jQuery Plugin)" data-title="Like"></div>
        <div id="googleplus" data-url="http://sharrre.com/" data-text="Make your sharing widget with Sharrre (jQuery Plugin)" data-title="+1"></div>
      </div>
    }
    end
    it "should return sharrre jQuery code" do
      @return_js_code = @dumb_class.rsocialize_js_tag({:js_template=>"example1"})
      @return_js_code.tr("\n","").tr(" ","").should == @js_code_example1.tr("\n","").tr(" ","")
    end
    it "should return html div code" do
      @return_html_code = @dumb_class.rsocialize_div_tag("",:css_template=>"example1")
      @return_html_code.tr("\n","").tr(" ","").should == @div_example1.tr("\n","").tr(" ","")
    end
  end #context example 1
  context "with EXAMPLE2_OPTIONS" do
    before(:each) do
      @dumb_class = DummyClass.new
      @js_code_example2 = %Q[
        <script>
$(document).ready(function() { $('#shareme').sharrre({
  share: {
    twitter: true,
    facebook: true,
    googlePlus: true
  },
  template: '<div class="box"><div class="left">Share</div><div class="middle"><a href="#" class="facebook">f</a><a href="#" class="twitter">t</a><a href="#" class="googleplus">+1</a></div><div class="right">{total}</div></div>',
  enableHover: false,
  enableTracking: true,
  render: function(api, options){
  $(api.element).on('click', '.twitter', function() {
    api.openPopup('twitter');
  });
  $(api.element).on('click', '.facebook', function() {
    api.openPopup('facebook');
  });
  $(api.element).on('click', '.googleplus', function() {
    api.openPopup('googlePlus');
  });
}
});
});
</script>
      ]
      @div_example2 = %Q{
        <div id="example2">
          <div id="shareme" data-url="http://sharrre.com/" data-text="Make your sharing widget with Sharrre (jQuery Plugin)"></div>
        </div>
      }
    end
    it "should return sharrre jQuery code" do
      @return_js_code = @dumb_class.rsocialize_js_tag({:js_template=>"example2"})
      @return_js_code.tr("\n","").tr(" ","").should == @js_code_example2.tr("\n","").tr(" ","")
    end
    it "should return html div code" do
      @return_html_code = @dumb_class.rsocialize_div_tag("",:css_template=>"example2")
      @return_html_code.tr("\n","").tr(" ","").should == @div_example2.tr("\n","").tr(" ","")
    end
  end #context example 2
  context "with EXAMPLE3_OPTIONS" do
    before(:each) do
      @dumb_class = DummyClass.new
      @js_code_example3 = %Q[<script>
$(document).ready(function() { $('#shareme').sharrre({
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
  hover: function(api, options){
    $(api.element).find('.buttons').show();
  },
  hide: function(api, options){
    $(api.element).find('.buttons').hide();
  }
});
});
</script>]
      @div_example3 = %Q{
        <div id="example3">
          <div id="shareme" data-url="http://sharrre.com/" data-text="Make your sharing widget with Sharrre (jQuery Plugin)" data-title="share this page"></div>
        </div>
      }
    end
    it "should return sharrre jQuery code" do
      @return_js_code = @dumb_class.rsocialize_js_tag({:js_template=>"example3"})
      @return_js_code.tr("\n","").tr(" ","").should == @js_code_example3.tr("\n","").tr(" ","")
    end
    it "should return html div code" do
      @return_html_code = @dumb_class.rsocialize_div_tag("",:css_template=>"example3")
      @return_html_code.tr("\n","").tr(" ","").should == @div_example3.tr("\n","").tr(" ","")
    end
  end #context example 3
  context "with EXAMPLE5_OPTIONS" do
    before(:each) do
      @dumb_class = DummyClass.new
      @js_code_example5 = %Q[<script>
$(document).ready(function() { $('#shareme').sharrre({
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
    pinterest: {media: 'http://sharrre.com/img/example1.png', description: $('#shareme').data('text'), layout: 'vertical'}
  },
  enableHover: false,
  enableCounter: false,
  enableTracking: true
});
});
</script>]
      @div_example5 = %Q{
        <div id="example5">
          <div id="shareme" data-url="http://sharrre.com/" data-text="Make your sharing widget with Sharrre (jQuery Plugin)"></div>
        </div>
      }
    end
    it "should return sharrre jQuery code" do
      @return_js_code = @dumb_class.rsocialize_js_tag({:js_template=>"example5"})
      @return_js_code.tr("\n","").tr(" ","").should == @js_code_example5.tr("\n","").tr(" ","")
    end
    it "should return html div code" do
      @return_html_code = @dumb_class.rsocialize_div_tag("",:css_template=>"example5")
      @return_html_code.tr("\n","").tr(" ","").should == @div_example5.tr("\n","").tr(" ","")
    end
  end #context example 5
  context "with EXAMPLE6_OPTIONS" do
    before(:each) do
      @dumb_class = DummyClass.new
      @js_code_example6 = %Q[<script>
$(document).ready(function() { $('#twitter').sharrre({
  share: {
    twitter: true
  },
  template: '<a class="box" href="#"><div class="count" href="#">{total}</div><div class="share"><span></span>Tweet</div></a>',
  enableHover: false,
  enableTracking: true,
  buttons: { twitter: {via: '_JulienH'}},
  click: function(api, options){
    api.simulateClick();
    api.openPopup('twitter');
  }
});
$('#facebook').sharrre({
  share: {
    facebook: true
  },
  template: '<a class="box" href="#"><div class="count" href="#">{total}</div><div class="share"><span></span>Like</div></a>',
  enableHover: false,
  enableTracking: true,
  click: function(api, options){
    api.simulateClick();
    api.openPopup('facebook');
  }
});
$('#googleplus').sharrre({
  share: {
    googlePlus: true
  },
  template: '<a class="box" href="#"><div class="count" href="#">{total}</div><div class="share"><span></span>+1</div></a>',
  enableHover: false,
  enableTracking: true,
  click: function(api, options){
    api.simulateClick();
    api.openPopup('googlePlus');
  }
});
});
</script>]
      @div_example6 = %Q{
        <div id="example6">
          <div id="twitter" data-url="http://sharrre.com/" data-text="Make your sharing widget with Sharrre (jQuery Plugin)"></div>
          <div id="facebook" data-url="http://sharrre.com/" data-text="Make your sharing widget with Sharrre (jQuery Plugin)"></div>
          <div id="googleplus" data-url="http://sharrre.com/" data-text="Make your sharing widget with Sharrre (jQuery Plugin)"></div>
        </div>
      }
    end
    it "should return sharrre jQuery code" do
      @return_js_code = @dumb_class.rsocialize_js_tag({:js_template=>"example6"})
      @return_js_code.tr("\n","").tr(" ","").should == @js_code_example6.tr("\n","").tr(" ","")
    end
    it "should return html div code" do
      @return_html_code = @dumb_class.rsocialize_div_tag("",:css_template=>"example6")
      @return_html_code.tr("\n","").tr(" ","").should == @div_example6.tr("\n","").tr(" ","")
    end
  end #context example 6
end #describe rsocialize
