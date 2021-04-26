require 'package'

class Ruby_webrick < Package
  description 'WEBrick is an HTTP server toolkit that can be configured as an HTTPS server, a proxy server, and a virtual-host server.'
  homepage 'https://github.com/ruby/webrick/'
  version '1.7.0'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ruby/webrick/archive/refs/tags/v1.7.0.tar.gz'
  source_sha256 '25df35c696301deddec8cc929954284fa3dfaa86ad90c0cce2ecc5740c476545'

  binary_url ({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/ruby_webrick-1.7.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/ruby_webrick-1.7.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/ruby_webrick-1.7.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/ruby_webrick-1.7.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bd2b9c9c252b056688c3423ec6b026a619e429734b9f4fa831c431d237ab3aee',
     armv7l: 'bd2b9c9c252b056688c3423ec6b026a619e429734b9f4fa831c431d237ab3aee',
       i686: 'c71f8b2b2c4bdafe1091dd1f45624ffa4257c38a94076acc4cf35cab4b84d06e',
     x86_64: 'a4bbdf449319a028cc8f2e8c112cd0de26930939a1c3bdc9cd751e9f1c73a41f',
  })

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
