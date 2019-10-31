require 'package'

class Xe < Package
  description 'simple xargs and apply replacement.'
  homepage 'https://github.com/chneukirchen/xe/'
  version '0.11'
  source_url 'https://github.com/chneukirchen/xe/archive/v0.11.tar.gz'
  source_sha256 '4087d40be2db3df81a836f797e1fed17d6ac1c788dcf0fd6a904f2d2178a6f1a'

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
