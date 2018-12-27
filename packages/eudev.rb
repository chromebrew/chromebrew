require 'package'

class Eudev < Package
  description 'Gentoo standalone udev'
  homepage 'https://wiki.gentoo.org/wiki/Project:Eudev'
  version '3.2.7'
  source_url 'https://github.com/gentoo/eudev/archive/v3.2.7.tar.gz'
  source_sha256 'ce2fda4dea129bbcf824c947aab23504bcd26911481b47dbaf10646f723083a4'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libxslt'
  depends_on 'gperf'
  depends_on 'util_linux'

  def self.build
    system 'sed -i s,/usr/bin/xsltproc,xsltproc,g man/make.sh'
    system './autogen.sh'
    system "./configure",
           "--enable-hwdb",
           "--enable-rule-generator",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--with-rootprefix=#{CREW_PREFIX}",
           "--with-rootlibdir=#{CREW_LIB_PREFIX}",
           "--with-rootrundir=#{CREW_PREFIX}/run",
           "--with-rootlibexecdir=#{CREW_PREFIX}/libexec"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
