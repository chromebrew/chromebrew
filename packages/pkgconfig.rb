require 'package'

class Pkgconfig < Package
  version '0.29.1'
  source_url 'http://pkgconfig.freedesktop.org/releases/pkg-config-0.29.1.tar.gz'
  source_sha1 '271ce928f6d673cc16cbced2bfd14a5f2e5d3d37'

  depends_on 'buildessential'

  def self.build
      # check lib64 on any architectures since it is not a problem to not exist lib64 directory.
      system "./configure --with-internal-glib --with-pc-path=/usr/local/lib/pkgconfig:/usr/local/lib64/pkgconfig:/usr/local/share/pkgconfig CFLAGS=\" -fPIC\""
      system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
