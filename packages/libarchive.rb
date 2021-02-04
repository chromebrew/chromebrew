require 'package'

class Libarchive < Package
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  @_ver = '3.5.1'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://www.libarchive.org/downloads/libarchive-#{@_ver}.tar.xz"
  source_sha256 '0e17d3a8d0b206018693b27f08029b598f6ef03600c2b5d10c94ce58692e299b'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.5.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.5.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.5.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.5.1-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd58404d09d291373169e80b4012ffb5c51f30760503769808b7a9e98111cfb68',
     armv7l: 'd58404d09d291373169e80b4012ffb5c51f30760503769808b7a9e98111cfb68',
       i686: 'b7634129d40fe7beed9185ce73ed78730c8255485d59d4316d67267a0b56c206',
     x86_64: '53a2d351d07063157a3ed33a8cf711af401b7adee4c72f4fa5772637e4823fa3'
  })

  depends_on 'lz4'
  depends_on 'xzutils' => :build

  def self.build
    raise StandardError, 'Please remove libiconv before building.' if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
