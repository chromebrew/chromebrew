# Adapted from Arch Linux glmark2 PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=glmark2

require 'package'

class Glmark2 < Package
  description 'OpenGL ES 2.0 benchmark'
  version '2020.04'
  compatibility 'all'
  source_url 'https://github.com/glmark2/glmark2/archive/2020.04.tar.gz'
  source_sha256 '0fa7723111c928a73c04d4fa4adfc15a9dea6d335fe189f59c74ae5af26f99a2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glmark2-2020.04-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glmark2-2020.04-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glmark2-2020.04-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glmark2-2020.04-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e4a59d48fdb44be2e3a8cbec3c0b9cd5c10a1dae8d07121010fd73b6986015d2',
     armv7l: 'e4a59d48fdb44be2e3a8cbec3c0b9cd5c10a1dae8d07121010fd73b6986015d2',
       i686: '49227b2fdedf881b927ca755404164587daf56ed1968854f2bb03071724d52a5',
     x86_64: '32ed34762096df02768643f7781c7e1a587ce95e6cfd0a5ddbf6c4720b87d923',
  })

  depends_on 'libjpeg_turbo'
  depends_on 'libpng'
  depends_on 'libx11'
  depends_on 'libxcb'


  def self.build
      system "python2 ./waf configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --with-flavors x11-gl,x11-glesv2"
      system "python2 ./waf"
  end
  
  def self.install
      system "python2 ./waf install --destdir=#{CREW_DEST_DIR}/"
  end
end
