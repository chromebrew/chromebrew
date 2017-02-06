require 'package'

class Go_unstable < Package
  version '1.8rc3'
  
  is_fake
  
  depends_on 'go'
  def self.install
    system "go get golang.org/x/build/version/go1.8rc3"
  end
end
