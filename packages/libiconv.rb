require 'package'

class Libiconv < Package
  description 'GNU charset conversion library for libc which does not implement it.'
  homepage 'https://www.gnu.org/software/libiconv/'
  version '1.16-4'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libiconv/libiconv-1.16.tar.gz'
  source_sha256 'e6a1b1b589654277ee790cce3734f07876ac4ccfaecbee8afa0b649cf529cc04'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '3328a5694b7eb6d44bfad79129aacb36f564ed597f31aafb54615635d50e1560',
     armv7l: '3328a5694b7eb6d44bfad79129aacb36f564ed597f31aafb54615635d50e1560',
       i686: 'efb5c2b71144f1cd413360a87634cf4a81dbcad568186315fb3d127460b68e65',
     x86_64: '378d0566c86141072f0b57f7aaf1e3bc7cac4c5dc88b4f9a441b5302fa549cc6'
  })

  def self.build
    system "env CFLAGS='-flto=auto -ltinfo' CXXFLAGS='-flto=auto' \
        LDFLAGS='-flto=auto' \
        ./configure #{CREW_OPTIONS} \
        --includedir=#{CREW_PREFIX}/include/gnu-libiconv \
        --enable-static \
        --enable-relocatable \
        --enable-extra-encodings"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/iconv", "#{CREW_DEST_PREFIX}/bin/gnu-libiconv-iconv"
    # Header files are moved to #{CREW_PREFIX}/include/gnu-libiconv
    # to avoid conflict with versions from glibc
  end
end
