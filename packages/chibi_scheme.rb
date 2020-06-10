require 'package'

class Chibi_scheme < Package
  description 'Minimal Scheme Implementation for use as an Extension Language'
  homepage 'http://synthcode.com/wiki/chibi-scheme'
  version '0.8'
  compatibility 'all'
  source_url 'https://github.com/ashinn/chibi-scheme/archive/0.8.tar.gz'
  source_sha256 '8a077859b123216c123c243db391b0fe4c0cf73978c7cdd7b8ea853a48192756'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/chibi_scheme-0.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/chibi_scheme-0.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/chibi_scheme-0.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/chibi_scheme-0.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c5ce68d2b060f78644b9b95d4c4bf900aec0787d5461d78ff4ccfca556d63e16',
     armv7l: 'c5ce68d2b060f78644b9b95d4c4bf900aec0787d5461d78ff4ccfca556d63e16',
       i686: '3c397e24bac2b7ebaaf822fd43ef5f2f44e2f3e2a3e469dbdfa70e3c51a13560',
     x86_64: 'b6c3320b5e3bd52980bfc8882b9117ad851ea2351dfa23a84fd108a470bbc3c4',
  })

  def self.patch
    system 'sed -i -e \'/LDCONFIG/d\' Makefile'
    system 'sed -i \'/^IMAGE_FILES =/c\IMAGE_FILES =\' Makefile' # wasn't able to override via CLI
  end

  def self.build
    system 'make', '-j1', "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system 'make', '-j1', "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
