require 'package'

class Fuse < Package
  version '2.9.7'
  source_url 'https://github.com/libfuse/libfuse/releases/download/fuse-2.9.7/fuse-2.9.7.tar.gz'
  source_sha1 'cd174e3d37995a42fad32fac92f76cd18e24174f'

  def self.build
    system "./configure \
              --prefix=/usr/local \
              --disable-kernel-module \
              --disable-static \
              INIT_D_PATH=/tmp/init.d"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
