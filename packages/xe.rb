require 'package'

class Xe < Package
  description 'simple xargs and apply replacement.'
  homepage 'https://github.com/chneukirchen/xe/'
  version '0.6.1'
  source_url 'https://github.com/chneukirchen/xe/archive/v0.6.1.tar.gz'
  source_sha256 '36036d0e9464233d3113af187c473491298ed1168976330d7dd615b8f0521b96'

  def self.build
    system "make", "PREFIX=/usr/local"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
