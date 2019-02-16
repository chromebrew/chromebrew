require 'package'

class Re2c < Package
  description 're2c is a free and open-source lexer generator for C and C++.'
  homepage 'http://re2c.org/'
  version '1.1.1'
  source_url 'https://github.com/skvadrik/re2c/releases/download/1.1.1/re2c-1.1.1.tar.gz'
  source_sha256 '856597337ea00b24ce91f549f79e6eece1b92ba5f8b63292cad66c14ac7451cf'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/re2c-1.1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/re2c-1.1.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/re2c-1.1.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/re2c-1.1.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e0afdfb419024f81bf62dd338ba6e80ef9a04abc83b8b4c1fd956ca6beed0902',
     armv7l: 'e0afdfb419024f81bf62dd338ba6e80ef9a04abc83b8b4c1fd956ca6beed0902',
       i686: '159d7224aac0c6649afb531f17d420a51a459ba1354ec91f6f9e1ca5f5d6f31c',
     x86_64: 'f1d91e37777b18324aea0e6dcad7927c50aed93daa91be6118a7760eebfa5b7a',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
    system 'make bootstrap'
  end

  def self.check
    system 'make check'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
