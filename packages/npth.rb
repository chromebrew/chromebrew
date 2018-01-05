require 'package'

class Npth < Package
  description 'nPth is a library to provide the GNU Pth API and thus a non-preemptive threads implementation.'
  homepage 'https://www.gnupg.org/related_software/npth/index.html'
  version '1.5-1'
  source_url 'https://www.gnupg.org/ftp/gcrypt/npth/npth-1.5.tar.bz2'
  source_sha256 '294a690c1f537b92ed829d867bee537e46be93fbd60b16c04630fbbfcd9db3c2'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
  system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
