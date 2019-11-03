require 'package'

class Chibi_scheme < Package
  description 'Minimal Scheme Implementation for use as an Extension Language'
  homepage 'http://synthcode.com/wiki/chibi-scheme'
  version '0.8'
  source_url 'https://github.com/ashinn/chibi-scheme/archive/0.8.tar.gz'
  source_sha256 '8a077859b123216c123c243db391b0fe4c0cf73978c7cdd7b8ea853a48192756'

  binary_url ({
  })
  binary_sha256 ({
  })


  def self.build
    system 'sed -i -e \'/LDCONFIG/d\' Makefile'
    system 'sed -i \'/^IMAGE_FILES =/c\IMAGE_FILES =\' Makefile' # wasn't able to override via CLI
    system 'make', '-j1', "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system 'make', '-j1', "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
