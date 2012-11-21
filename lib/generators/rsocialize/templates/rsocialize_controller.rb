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
  $_GET = Hash.new
  #$_GET['url'] = 'http://sharrre.com/'  ##In PHP, the predefined $_GET variable is used to collect values in a form with method="get".
  $_GET['url'] = params[:url]
  $_GET['type'] = params[:type]
  #source: http://www.rubyinside.com/nethttp-cheat-sheet-2940.html
  uri = URI.parse($_GET['url'])
  http = Net::HTTP.new(uri.host, uri.port)
  
  @json = {'url'=>'','count'=>0}
  @json['url'] = $_GET['url'];
  @url = CGI::escape($_GET['url']);
  @type = CGI::escape($_GET['type']);
  #Get HTTP response code
  response = Net::HTTP.get_response(uri)
  if(response.code=="200")   ##need to make this FILTER_VALIDATE_URL equivalent in ruby
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
     elsif (@type == 'pinterest')
       @content = parse("http://api.pinterest.com/v1/urls/count.json?callback=&url=#{@url}");
       @result = ActiveSupport::JSON.decode(@content.body_str.gsub(/[()]/,""))
       @json['count'] = @result['count']
       @json['count'] = 0 if (@json['count'].nil?||@json['count']=="-")
     end
  end
  #@json => {"url"=>"http://www.google.com/", "count"=>"1.5M"}
  #@return_json = ActiveSupport::JSON.encode(@json)
  #=> "{\"url\":\"http://www.google.com/\",\"count\":\"1.5M\"}"
  # respond_to do |format|
    # format.json { render json: @return_json }    
  # end
  render :json=>@json
end

def parse(encUrl)
  #curb method docs for curl::Easy: http://curb.rubyforge.org/classes/Curl/Easy.html#M000038
    @options = Hash.new
    
  #curl_setopt() constants in php: http://www.php.net/manual/en/function.curl-setopt.php for translation in ruby below
    @options = {
      :CURLOPT_RETURNTRANSFER => true, #// return web page  #TRUE to return the transfer as a string of the return value of php curl_exec() instead of outputting it out directly.
      :CURLOPT_HEADER => false, #// don't return headers #TRUE to include the header in the output.
      :CURLOPT_FOLLOWLOCATION => true, #// follow redirects
      :CURLOPT_ENCODING => "", #// handle all encodings
      :CURLOPT_USERAGENT => 'sharrre', #// who am i
      :CURLOPT_AUTOREFERER => true, #// set referer on redirect
      :CURLOPT_CONNECTTIMEOUT => 5, #// timeout on connect
      :CURLOPT_TIMEOUT => 10, #// timeout on response
      :CURLOPT_MAXREDIRS => 3, #// stop after 10 redirects
      :CURLOPT_SSL_VERIFYHOST => false,
      :CURLOPT_SSL_VERIFYPEER => false,
    }
    
    @options[:CURLOPT_URL] = encUrl  
 @content= Curl::Easy.http_get(@options[:CURLOPT_URL]) do |curl|  
      #curl.returntransfer = ?????
      curl.head = @options[:CURLOPT_HEADER]  #???  #not sure if it's headers
      curl.follow_location = @options[:CURLOPT_FOLLOWLOCATION]
      curl.encoding = @options[:CURLOPT_ENCODING]
      curl.useragent = @options[:CURLOPT_USERAGENT]
      curl.autoreferer = @options[:CURLOPT_AUTOREFERER]
      curl.connect_timeout = @options[:CURLOPT_CONNECTTIMEOUT]
      curl.timeout = @options[:CURLOPT_TIMEOUT]
      curl.max_redirects = @options[:CURLOPT_MAXREDIRS]
      curl.ssl_verify_host = @options[:CURLOPT_SSL_VERIFYHOST]
      curl.ssl_verify_peer = @options[:CURLOPT_SSL_VERIFYPEER]
    end 
    
    #NOTE: may need to add error handling for curl
  
    return @content;
end

end #Rsocialize