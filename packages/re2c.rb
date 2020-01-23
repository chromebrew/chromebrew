require 'package'

class Re2c < Package
  description 're2c is a free and open-source lexer generator for C and C++.'
  homepage 'http://re2c.org/'
  version '1.3'
  source_url 'https://github.com/skvadrik/re2c/releases/download/1.3/re2c-1.3.tar.xz'
  source_sha256 'f37f25ff760e90088e7d03d1232002c2c2672646d5844fdf8e0d51a5cd75a503'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/re2c-1.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/re2c-1.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/re2c-1.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/re2c-1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1ee30785ba83b9ed00258fa126f18a14e687cd4902a20f10b9bf1ce322f4692f',
     armv7l: '1ee30785ba83b9ed00258fa126f18a14e687cd4902a20f10b9bf1ce322f4692f',
       i686: '0fefae6d421dbe3166a1cefd28473264423d158ee52b41b3aec3cfb7ccfb5526',
     x86_64: 'a4639d6224bf8537e25703f03161a3f849e05160d40282b274b91611a674b069',
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
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
