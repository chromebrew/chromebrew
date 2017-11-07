require 'package'

class Libopus < Package
  description 'Opus is a totally open, royalty-free, highly versatile audio codec.'
  homepage 'http://opus-codec.org/'
  version '1.1.5'
  source_url 'https://archive.mozilla.org/pub/opus/opus-1.1.5.tar.gz'
  source_sha256 'eb84981ca0f40a3e5d5e58d2e8582cb2fee05a022825a6dfe14d14b04eb563e4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libopus-1.1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libopus-1.1.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libopus-1.1.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libopus-1.1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '75b4e3681d7b46dae1f6f9c6c9680b39410eb0891fc22ad5b25f2d9e1da84c7d',
     armv7l: '75b4e3681d7b46dae1f6f9c6c9680b39410eb0891fc22ad5b25f2d9e1da84c7d',
       i686: '246aebbbd0a83d9fe98d2dcb08e289731ca91d72ef8a0233c8b15d9d32968253',
     x86_64: '5aec178bc2b59e314eb5845f645bd20909297a256511bf9b954c5f6df716c840',
  })

  def self.build
    system "./configure --prefix=/usr/local \
            --enable-shared \
            --enable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
