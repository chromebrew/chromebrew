require 'package'
require './chrome.rb'

class Google_chrome < Package
  description 'Google Chrome is a fast, easy to use, and secure web browser.'
  homepage 'https://www.google.com/chrome'
  compatibility 'x86_64'
  version Chrome.version
  
  is_fake
  
  depends_on 'chrome'
end
