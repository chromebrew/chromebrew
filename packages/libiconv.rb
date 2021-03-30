require 'package'

class Libiconv < Package
  description 'GNU charset conversion library for libc which does not implement it.'
  homepage 'https://www.gnu.org/software/libiconv/'
  version '1.16-4-1'
  license 'LGPL-2+ and GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libiconv/libiconv-1.16.tar.gz'
  source_sha256 'e6a1b1b589654277ee790cce3734f07876ac4ccfaecbee8afa0b649cf529cc04'

  def self.build
    system "env CFLAGS='-flto=auto -ltinfow' CXXFLAGS='-flto=auto' \
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
