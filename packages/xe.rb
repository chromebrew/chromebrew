require 'package'

class Xe < Package
  description 'simple xargs and apply replacement.'
  homepage 'https://github.com/chneukirchen/xe/'
  version '0.10'
  source_url 'https://github.com/chneukirchen/xe/archive/v0.10.tar.gz'
  source_sha256 '8993cea06b2c664195df2a6124d0386d1bce7c27eb6ecbf968866bfd05cb9d7a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xe-0.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xe-0.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xe-0.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xe-0.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a8abe1abf912587ec016f7bdeab423c7a60f750c2da52bc298e4b64006affd97',
     armv7l: 'a8abe1abf912587ec016f7bdeab423c7a60f750c2da52bc298e4b64006affd97',
       i686: '346d26cca7c6baf20a2fa375f5c8078c602b1cd472a47b0acca5ce12c507d4cd',
     x86_64: 'd19c870b8a7671d590b7f383507d384e6a8d0591c50b72af8f12cb0eca01aec5',
  })

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
