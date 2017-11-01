require 'package'

class Swig < Package
  description 'Simplified Wrapper and Interface Generator'
  homepage 'http://www.swig.org'
  version '3.0.12'
  source_url 'http://prdownloads.sourceforge.net/swig/swig-3.0.12.tar.gz'
  source_sha256 '7cf9f447ae7ed1c51722efc45e7f14418d15d7a1e143ac9f09a668999f4fc94d'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'pcre'
  depends_on 'zlibpkg'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
