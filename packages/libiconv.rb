require 'package'

class Libiconv < Package
  description 'GNU charset conversion library for libc which does not implement it.'
  homepage 'https://www.gnu.org/software/libiconv/'
  version '1.16-4'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libiconv/libiconv-1.16.tar.gz'
  source_sha256 'e6a1b1b589654277ee790cce3734f07876ac4ccfaecbee8afa0b649cf529cc04'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-4-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-4-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-4-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '856c11ac045ce6c053e13e9bf1e1b4342a3426c32213a3d3337a214fa6cf86c0',
      armv7l: '856c11ac045ce6c053e13e9bf1e1b4342a3426c32213a3d3337a214fa6cf86c0',
        i686: '0929057c23923347d7090a6d9852bc1c1c99f3124bd5a30fcc6ac8b440f2bc36',
      x86_64: '6c390d85b7570fa2dd97c3d33ace2f28ee55677f5b6f2513f05220b50eb55570',
  })

  def self.build
    system "env CFLAGS='-flto=auto -ltinfo' CXXFLAGS='-flto=auto' \
        LDFLAGS='-flto=auto' \
        ./configure #{CREW_OPTIONS} \
        --enable-static \
        --enable-relocatable \
        --enable-extra-encodings"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Don't remove iconv.h. Better not to have this installed if you don't
    # want a comflict.
    # Remove iconv.h which conflicts with same file from glibc
    # FileUtils.rm "#{CREW_DEST_PREFIX}/include/iconv.h"
  end
end
