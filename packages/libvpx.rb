require 'package'

class Libvpx < Package
  version '1.6.1'
  source_url 'https://github.com/webmproject/libvpx/archive/v1.6.1.tar.gz'
  source_sha1 '9e41a6bb2b991f5542c264676ac452114cda9c7c'

  def self.build
    system "./configure --prefix=/usr/local \
            --enable-shared \
            --enable-vp8 \
            --enable-vp9 \
            --enable-postproc \
            --enable-vp9-postproc \
            --enable-webm-io"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
