require 'package'

class Swig < Package
  description 'Simplified Wrapper and Interface Generator'
  homepage 'http://www.swig.org'
  version '3.0.12'
  source_url 'http://prdownloads.sourceforge.net/swig/swig-3.0.12.tar.gz'
  source_sha256 '7cf9f447ae7ed1c51722efc45e7f14418d15d7a1e143ac9f09a668999f4fc94d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/swig-3.0.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/swig-3.0.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/swig-3.0.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/swig-3.0.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e01ff7b79ecee04da5ab1e36ddbffb016d570d78c91187f6a9b4c000c615a541',
     armv7l: 'e01ff7b79ecee04da5ab1e36ddbffb016d570d78c91187f6a9b4c000c615a541',
       i686: '88e6f649ef905cf852ab4a51594f1497c0b2be93f4a5c9ef737ee2a2376f489d',
     x86_64: '1ada3fd45ea500a386c1ed491b0520ceb0a822f151d70fe0019446f0b05cc8e8',
  })

  depends_on 'pcre'
  depends_on 'zlibpkg'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
