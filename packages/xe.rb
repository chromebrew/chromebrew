require 'package'

class Xe < Package
  description 'simple xargs and apply replacement.'
  homepage 'https://github.com/chneukirchen/xe/'
  version '0.10'
  source_url 'https://github.com/chneukirchen/xe/archive/v0.10.tar.gz'
  source_sha256 '8993cea06b2c664195df2a6124d0386d1bce7c27eb6ecbf968866bfd05cb9d7a'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
