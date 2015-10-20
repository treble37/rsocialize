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
