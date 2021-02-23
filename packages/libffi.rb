require 'package'

class Libffi < Package
  description 'The libffi library provides a portable, high level programming interface to various calling conventions.'
  homepage 'https://sourceware.org/libffi/'
  version '3.3-1'
  compatibility 'all'
  source_url 'https://sourceware.org/pub/libffi/libffi-3.3.tar.gz'
  source_sha256 '72fba7922703ddfa7a028d513ac15a85c8d54c8d67f55fa5a4802885dc652056'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libffi-3.3-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libffi-3.3-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libffi-3.3-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libffi-3.3-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'feed096aa4b48a2ccaa2be5f8998f775eeeab873fc2d582b06c15acd1a380d74',
     armv7l: 'feed096aa4b48a2ccaa2be5f8998f775eeeab873fc2d582b06c15acd1a380d74',
       i686: 'd76faf5d8917ad57be1414cdbd915a70f978494aac09fcdd73f80c3db8fb21e4',
     x86_64: 'acd8ad06dbc7a6f83b8bdce10aa53b72817ab5468548bb4d09a715ab1b1b9b68'
  })

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --enable-shared \
      --with-pic \
      --disable-debug \
      --disable-dependency-tracking"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    # system "make check"         # DejaGNU required
  end
end
