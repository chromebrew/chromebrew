require 'package'

class Xe < Package
  description 'simple xargs and apply replacement.'
  homepage 'https://github.com/chneukirchen/xe/'
  version '0.6.1'
  source_url 'https://github.com/chneukirchen/xe/archive/v0.6.1.tar.gz'
  source_sha1 '76c0a31c4d646314c3e92753a2fec3ae7cedad1d'

  def self.build
    system "make", "PREFIX=/usr/local"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end
