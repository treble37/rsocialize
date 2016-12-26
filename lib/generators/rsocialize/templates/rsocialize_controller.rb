require 'cgi'
require 'net/http'
require 'uri'
require 'open-uri'
require 'curb'
require 'active_support' #for json decode/encode
require 'nokogiri'
require 'rsocialize'

class RsocializeController < ApplicationController

def sharrre
  #$_GET['url'] = 'http://sharrre.com/'  ##In PHP, the predefined $_GET variable is used to collect values in a form with method="get". For ruby conventions, we'll use a snake case type var.
  @get = { 'url' => params[:url], 'type' => params[:type] }
  uri = URI.parse(@get['url'])
  http = Net::HTTP.new(uri.host, uri.port)

  @json = {'url'=>@get['url'],'count'=>0}
  @url = CGI::escape(@get['url']);
  @type = CGI::escape(@get['type']);
  #Get HTTP response code
  response = Net::HTTP.get_response(uri)
  if(response.code=="200")
    ##need to make this FILTER_VALIDATE_URL equivalent in ruby as the php script in sharrre.php
     if (@type == 'googlePlus')
       @content = parse("https://plusone.google.com/u/0/_/+1/fastbutton?url="+"#{@url}"+"&count=true");
       doc = Nokogiri::HTML(open("https://plusone.google.com/u/0/_/+1/fastbutton?url="+"#{@url}"+"&count=true"))
       doc.xpath("//div[@id='aggregateCount']").each do |node|
         @json['count'] = node.content  #only one item returned, so it'd be great to not have to iterate
       end
     elsif (@type == 'stumbleupon')
       @content = parse("http://www.stumbleupon.com/services/1.01/badge.getinfo?url=#{@url}");
       @result = ActiveSupport::JSON.decode(@content.body_str) #json_decode takes a JSON encoded string and converts it into a PHP variable.
       @json['count'] =  @result['result']['views']
       @json['count'] = 0 if @json['count'].nil?
     end
  end

  render :json => @json
end

def parse(enc_url)
  #curl_setopt() constants in php: http://www.php.net/manual/en/function.curl-setopt.php for translation in ruby below
    @options = {
      :curlopt_url => enc_url,
      :curlopt_followlocation => true, #// follow redirects
      :curlopt_encoding => "", #// handle all encodings
      :curlopt_useragent => 'sharrre', #// who am i
      :curlopt_autoreferer => true, #// set referer on redirect
      :curlopt_connecttimeout => 5, #// timeout on connect
      :curlopt_timeout => 10, #// timeout on response
      :curlopt_maxredirs => 3, #// stop after 10 redirects
      :curlopt_ssl_verifyhost => false,
      :curlopt_ssl_verifypeer => false,
    }

 @content= Curl::Easy.http_get(@options[:curlopt_url]) do |curl|
      curl.follow_location = @options[:curlopt_followlocation]
      curl.encoding = @options[:curlopt_encoding]
      curl.useragent = @options[:curlopt_useragent]
      curl.autoreferer = @options[:curlopt_autoreferer]
      curl.connect_timeout = @options[:curlopt_connecttimeout]
      curl.timeout = @options[:curlopt_timeout]
      curl.max_redirects = @options[:curlopt_maxredirs]
      curl.ssl_verify_host = @options[:curlopt_ssl_verifyhost]
      curl.ssl_verify_peer = @options[:curlopt_ssl_verifypeer]
    end

    return @content;
end

end #Rsocialize
