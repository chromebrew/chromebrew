require 'package'

class Swig < Package
  description 'Simplified Wrapper and Interface Generator'
  homepage 'http://www.swig.org'
  version '4.0.1'
  source_url 'http://prdownloads.sourceforge.net/swig/swig-4.0.1.tar.gz'
  source_sha256 '7a00b4d0d53ad97a14316135e2d702091cd5f193bb58bcfcd8bc59d41e7887a9'

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
