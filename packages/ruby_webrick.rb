require 'package'

class Ruby_webrick < Package
  description 'WEBrick is an HTTP server toolkit that can be configured as an HTTPS server, a proxy server, and a virtual-host server.'
  homepage 'https://github.com/ruby/webrick/'
  version '1.7.0'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ruby/webrick/archive/refs/tags/v1.7.0.tar.gz'
  source_sha256 '25df35c696301deddec8cc929954284fa3dfaa86ad90c0cce2ecc5740c476545'

  def self.build
    system 'rake', 'build'
  end

  def self.check
    system 'rake', 'test'
  end

  def self.install
    system 'gem', 'install', "--build=#{CREW_DEST_DIR}", 'pkg/webrick-1.7.0.gem'
  end
end
