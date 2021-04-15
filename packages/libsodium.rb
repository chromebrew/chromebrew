require 'package'

class Libsodium < Package
  description 'A modern, portable, easy to use crypto library'
  homepage 'https://libsodium.org'
  version '1.0.18-7168'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/jedisct1/libsodium.git'
  git_hashtag '7168944f16e12c1b630e66a7b9be0802d5b564dd'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/libsodium-1.0.18-7168-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/libsodium-1.0.18-7168-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/libsodium-1.0.18-7168-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/libsodium-1.0.18-7168-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '8cf24abf23f1ec6b19052e29b5cc80db8f2b6917dae193827c99a02349839221',
     armv7l: '8cf24abf23f1ec6b19052e29b5cc80db8f2b6917dae193827c99a02349839221',
       i686: 'ab1a37ec01e04271deca45cfb8943dc8d379e12c4d154a4d190824e1de6c0daa',
     x86_64: 'f5ad9b26a80254a30e8aaced54eeb19e8962980b888df9d904a6377d7dce9cff'
  })

  def self.build
      system 'NOCONFIGURE=1 ./autogen.sh'
      system "env #{CREW_ENV_OPTIONS} \
        ./configure #{CREW_OPTIONS}"
      system 'make'
  end

  def self.install
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    Dir.chdir @git_dir do
      system 'make', 'check'
    end
  end
end
