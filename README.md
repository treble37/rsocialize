[![Code Climate](https://codeclimate.com/github/treble37/rsocialize/badges/gpa.svg)](https://codeclimate.com/github/treble37/rsocialize)

[![Test Coverage](https://codeclimate.com/github/treble37/rsocialize/badges/coverage.svg)](https://codeclimate.com/github/treble37/rsocialize/coverage)

##Help contribute to the development & maintenance of this gem via GitTip:

[![Gratipay](https://img.shields.io/gratipay/treble37.svg)](https://gratipay.com/treble37/)

Hey Internet, I make most of my money during the day by working just like everyone else, so seeing a donation really helps motivate me to keep improving this gem.  Even if you don't donate, please feel free to leave me feedback / feature requests / issues via the Github issues.

# Rsocialize Description

This is a ruby on rails gem that enables easy installation of the [sharrre](http://sharrre.com/) jQuery plugin.  It provides a simple way to add social media buttons to your rails application.  No more digging through APIs or copying and pasting code from developer docs just to install social media buttons for your rails application.

#Rsocialize - Who is it for?

This gem is ideal for one-person (or severely time-pressed) startups who are time-limited and just need to get some social media buttons installed quickly, because they're really busy working on so many other aspects of deployment.

#Rsocialize v0.0.4 - What's working?

This is a "beta" release.  There's been some minimal testing with rspec.  In the current version, I have examples 1,2,3,5 and 6 from the sharrre plugin working in Rails.  Users can use their own custom css and specify their own sharrre options to use different buttons than the ones given in examples 1,2,3,5,6.

#Rails compatibility

##Rails 3.x

I initially wrote this gem and tested it with Rails 3.2.8. It takes advantage of the asset pipeline.  Now that Rails 4.x is out, a few things that worked with Rails 3.2.x are incompatible and so I have moved the Rails 3 compatible code to the rails-3.x branch.

##Rails 4.x
A few dependencies were out of date - namely, activesupport, nokogiri, and actionpack.  Also, there was an issue with the way the route was specified in that Rails 4 apparently no longer allows [controller names to be capitalized in the routes file](https://github.com/rails/rails/blob/v4.0.0/actionpack/lib/action_dispatch/routing/mapper.rb#L237)

The master branch always incorporates the latest branch updates (e.g., so if rails-4.1-stable is the latest branch, then master mirrors rails-4.1-stable)

## Installation

Add this line to your application's Gemfile:

###For Rails 3

    gem 'rsocialize', :git => "git://github.com//treble37/rsocialize.git", :branch => "rails-3.x"

###For Rails 4

    gem 'rsocialize'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rsocialize

## Basic Usage

###Installation w/your rails application

At the command prompt:

`rails g rsocialize:install example1`

This will install the required sharrre jQuery code and the Example 1 CSS into your app/assets directory.  It will also create a route in your routes.rb file and a controller file.  This part is "auto-magic" and done for you.

Now in your view(s) file or on whatever page you want the social media buttons to appear, you need to use the following 2 helper functions:

`rsocialize_div_tag("", {:div_template=>"example1"})`

The *_div_tag helper outputs the necessary css for sharrre's Example 1. 

`rsocialize_js_tag({:js_template=>"example1"})`

The *_js_tag helper outputs the necessary jQuery Code for sharrre's Example 1.

You would use "example2", "example3", etc. as the argument if you wanted the Example 2, Example 3, etc. style buttons to be used.  

###Uninstalling from your rails application
At the command prompt:

`rails g rsocialize:uninstall`

## Advanced Usage with Custom Options

To use social buttons different than what is pre-loaded with the examples, you have to perform the following steps:
1.  Specify your own (nested) hash of custom options to pass into rsocialize_js_tag so that the proper jQuery code is returned in your view
2.  Specify your own html `<div>` markup for the jQuery code to operate on, which should be passed into rsocialize_div_tag
3.  Overwrite the css code in the rsocialize.css file for any custom css styling you want to be applied

###For step 1 - example of specifying the hash of options
```ruby
@js_custom_options = {
   demo1: {
          share: {
              googlePlus: true,
              facebook: true,
              twitter: true
            },
            buttons: {
              googlePlus: {size: 'tall'},
              facebook: {layout: 'box_count'},
              twitter: {count: 'vertical', via: '_JulienH'}
            },
            hover: %Q[function(api, options){
              $(api.element).find('.buttons').show();
            }],
            hide: %Q[function(api, options){
              $(api.element).find('.buttons').hide();
            }],
            enableTracking: true
          }
   }
```

You would then call the following in your view:
`<%= rsocialize_js_tag(@js_custom_options) %>`

###For step 2 - example of specifying own html `<div>` markup for the jQuery code to operate on
```ruby
 @custom_div = %Q{
        <div id="demo1" data-url="http://sharrre.com" data-text="Make your sharing widget with Sharrre (jQuery Plugin)" data-title="share"></div>
     }
````
     
You would then call the following in your view:
`rsocialize_div_tag(@custom_div,:div_template=>"custom") %>`

The *custom* option essentially tells the *_div_tag helper to return whatever html markup you pass in.

###For step 3 - overwrite the css code in the rsocialize.css file for any custom css styling you want to be applied
This is pretty straightforward.  If you don't like the default css (or whatever option you installed), you can overwrite via copy/paste or you can use the *switch_css* command.  To use the *switch_css* command:

`rails g rsocialize:switch_css example2`

Note that the argument "example2" refers to the "example2css.txt" file in the "app/assets/stylesheets" directory.  If you have your own custom css file that you want to switch in and out, you can always create your own text file in the "app/assets/stylesheets" directory.  The file should be named according to the convention *css.txt, where * = any bunch of characters.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

##Resources Used:
1.  [Javascript compression tool http://jscompress.com/](http://jscompress.com/)
2.  [Sharrre home page](http://sharrre.com/)

TODOS:

- [ ] Update badge [![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/treble37/rsocialize/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
- [ ] Use different regex match from https://github.com/Julienh/Sharrre/blob/master/sharrre.php#L14 ?
