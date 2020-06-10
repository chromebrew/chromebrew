require 'package'

class Libxtst < Package
  description 'X.org Xtst Library'
  homepage 'http://t2sde.org/packages/libxtst.html'
  version '1.2.3'
  compatibility 'all'
  source_url 'https://xorg.freedesktop.org/releases/individual/lib/libXtst-1.2.3.tar.bz2'
  source_sha256 '4655498a1b8e844e3d6f21f3b2c4e2b571effb5fd83199d428a6ba7ea4bf5204'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxtst-1.2.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxtst-1.2.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxtst-1.2.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxtst-1.2.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '032782d5f6b4eff989dead39660124c9248d6612b41f5a7ad065172e9fdbdb2a',
     armv7l: '032782d5f6b4eff989dead39660124c9248d6612b41f5a7ad065172e9fdbdb2a',
       i686: '3d551292dcd4c6098790203c6028f367ba8c1b8d205395d5a3dbdbbef08ee572',
     x86_64: '0649bbebfbe8c632cd06507115fc3d546aaf5c851248f8b052119bbdbaee699a',
  })


  depends_on 'libxi'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
