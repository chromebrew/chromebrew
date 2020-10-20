# Adapted from Arch Linux glmark2 PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=glmark2

require 'package'

class Glmark2 < Package
  description 'OpenGL ES 2.0 benchmark'
  version '2020.04'
  compatibility 'all'
  source_url 'https://github.com/glmark2/glmark2/archive/2020.04.tar.gz'
  source_sha256 '0fa7723111c928a73c04d4fa4adfc15a9dea6d335fe189f59c74ae5af26f99a2'

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
