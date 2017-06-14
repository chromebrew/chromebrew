require 'package'

class Pkgconfig < Package
  description 'pkg-config is a helper tool used when compiling applications and libraries.'
  homepage 'https://www.freedesktop.org/wiki/Software/pkg-config/'
  version '0.29.2'
  source_url 'http://pkgconfig.freedesktop.org/releases/pkg-config-0.29.2.tar.gz'
  source_sha1 '76e501663b29cb7580245720edfb6106164fad2b'

  # It is not possible to write buildessential here since it causes dependency loop.
  #   depends_on 'buildessential'
  # Write dependency to gcc make linuxheaders instead.
  depends_on 'gcc'
  depends_on 'linuxheaders'
  depends_on 'make'

  def self.build
      # check lib64 on any architectures since it is not a problem to not exist lib64 directory.
      system "./configure", "--with-internal-glib", "--with-pc-path=/usr/local/lib/pkgconfig:/usr/local/lib64/pkgconfig:/usr/local/share/pkgconfig"
      system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end

  def self.check
    system "make", "check"
  end
end
