require 'package'

class E2fsprogs < Package
  version '1.42.13'

  binary_url ({
    x86_64: 'https://dl.bintray.com/brunux/chromebrew/e2fsprogs-1.42.13-chromebrew.tar.gz'
  })
  binary_sha1 ({
    x86_64: '7a125051ebabbd7eea6e9dc839253860dbc28a45'
  })

  source_url 'https://dl.bintray.com/brunux/chromebrew/files/e2fsprogs-1.42.13-src.tar.bz2' 
  source_sha1 '77d1412472ac5a67f8954166ec16c37616074c37'

  depends_on 'buildessential'
  depends_on 'make'
  depends_on 'binutils'
  depends_on 'diffutils'
  depends_on 'glibc'
  depends_on 'gawk'
  depends_on 'gcc'
  depends_on 'pkgconfig'

  def self.build  
    system "mkdir build"
    system "cd build"
    system "LIBS=-L/tools/lib"
    system "CFLAGS=-I/tools/include"
    system "PKG_CONFIG_PATH=/usr/local/bin/pkg-config"
    system "../configure --prefix=/usr/local --bindir=/usr/local/bin --enable-elf-shlibs --disable-uuidd --disable-fsck"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-libs"
    system "ls /usr/local/sbin/ | sudo xargs -I {} ln -sv /usr/local/sbin/{} /usr/local/bin/{}"
    system "cd", ".."
    system "rm", "-rf", "build"
  end
end
