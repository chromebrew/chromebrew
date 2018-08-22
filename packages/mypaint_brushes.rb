require 'package'

class Mypaint_brushes < Package
  description 'Brushes used by MyPaint and other software using libmypaint.'
  homepage 'https://github.com/Jehan/mypaint-brushes'
  version '1.3.0'
  source_url 'https://github.com/Jehan/mypaint-brushes/archive/v1.3.0/mypaint-brushes-v1.3.0.tar.gz'
  source_sha256 '704bb6420e65085acfd7a61d6050e96b0395c5eab078433f11406c355f16b214'

  depends_on 'libmypaint'

  def self.patch
    system "wget http://www.linuxfromscratch.org/patches/blfs/svn/mypaint-brushes-1.3.0-automake_1.16-1.patch"
    system "patch -Np1 -i mypaint-brushes-1.3.0-automake_1.16-1.patch"
  end

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
