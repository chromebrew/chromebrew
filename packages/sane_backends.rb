require 'package'

class Sane_backends < Package
  description 'Scanner Access Now Easy - Backends'
  homepage 'http://www.sane-project.org/'
  version '1.0.27'
  compatibility 'all'
  source_url 'https://gitlab.com/sane-project/backends/-/archive/RELEASE_1_0_27/backends-RELEASE_1_0_27.tar.bz2'
  source_sha256 '6a4034a9d29255bb40cf5a19f3d85dd7ba4fe6452eb9b1ae4385bc8175493ec4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sane_backends-1.0.27-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sane_backends-1.0.27-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sane_backends-1.0.27-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sane_backends-1.0.27-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '88808a041b13f2cc49fcc997e79ee2976010613d4961a552022b5a1d9887fd98',
     armv7l: '88808a041b13f2cc49fcc997e79ee2976010613d4961a552022b5a1d9887fd98',
       i686: '890abd21b508d9efc1a91e7738f00b58589110c536b79b9df8c3ee12b5f39e4c',
     x86_64: 'b585e6efcc75a0d54dc1468d6e9fa00445af1a5ceb01752dc11d7ad65a101efc',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
