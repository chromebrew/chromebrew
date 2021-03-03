require 'package'

class Jansson < Package
  description 'Jansson is a C library for encoding, decoding and manipulating JSON data.'
  homepage 'http://www.digip.org/jansson/'
  @_ver = '2.13.1'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/akheron/jansson/archive/v#{@_ver}.tar.gz"
  source_sha256 'f22901582138e3203959c9257cf83eba9929ac41d7be4a42557213a22ebcc7a0'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jansson-2.13.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jansson-2.13.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jansson-2.13.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jansson-2.13.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '934cd7813f9a0c8ad07c967f0d65de05a545d697cc10c6a270c09e6dbbdf30df',
     armv7l: '934cd7813f9a0c8ad07c967f0d65de05a545d697cc10c6a270c09e6dbbdf30df',
       i686: '3a4c91fbfd2b20b52174e9dfb28b16d1ed22767af66379711e1da77ac9ec9e86',
     x86_64: '224290a4b9c5e4361d7a41171745ec02211281582af9a6f7aa0b7de47a06b7de'
  })

  def self.build
    system 'autoreconf -i'
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
