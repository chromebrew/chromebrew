require 'package'

class Ruby_webrick < Package
  description 'WEBrick is an HTTP server toolkit that can be configured as an HTTPS server, a proxy server, and a virtual-host server.'
  homepage 'https://github.com/ruby/webrick/'
  version '1.7.0-ruby-3.2'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ruby/webrick/archive/refs/tags/v1.7.0.tar.gz'
  source_sha256 '25df35c696301deddec8cc929954284fa3dfaa86ad90c0cce2ecc5740c476545'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_webrick/1.7.0-ruby-3.2_armv7l/ruby_webrick-1.7.0-ruby-3.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_webrick/1.7.0-ruby-3.2_armv7l/ruby_webrick-1.7.0-ruby-3.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_webrick/1.7.0-ruby-3.2_i686/ruby_webrick-1.7.0-ruby-3.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_webrick/1.7.0-ruby-3.2_x86_64/ruby_webrick-1.7.0-ruby-3.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4e5d6a1bd3bc479226f138fbb41ddb9bf785c1c1027cd8d679bf6fe41f2b5c73',
     armv7l: '4e5d6a1bd3bc479226f138fbb41ddb9bf785c1c1027cd8d679bf6fe41f2b5c73',
       i686: 'd9567362271e89eff931f8affcc05d156f4afcbb48e5c02b9a665e6bd3872168',
     x86_64: '95858ae4902127b8ec7790bc7b4d287e27ec20409a5dcd789460e7a3fa74fc22'
  })

  depends_on 'libyaml'
  depends_on 'ruby'

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
