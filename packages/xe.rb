require 'package'

class Xe < Package
  description 'simple xargs and apply replacement.'
  homepage 'https://github.com/chneukirchen/xe/'
  version '0.9'
  source_url 'https://github.com/chneukirchen/xe/archive/v0.9.tar.gz'
  source_sha256 '0e72bafd0d5c30953ef7a5dca710296aec621a60fb62c0aaf7ee2af5e68c2ac2'

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
