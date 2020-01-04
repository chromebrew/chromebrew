require 'package'

class Eudev < Package
  description 'Gentoo standalone udev'
  homepage 'https://wiki.gentoo.org/wiki/Project:Eudev'
  version '3.2.9'
  source_url 'https://github.com/gentoo/eudev/archive/v3.2.9.tar.gz'
  source_sha256 '7d281276b480da3935d1acb239748c2c9db01a8043aad7e918ce57a223d8cd24'

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
    system './configure',
           '--enable-hwdb',
           '--enable-rule-generator',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--with-rootprefix=#{CREW_PREFIX}",
           "--with-rootlibdir=#{CREW_LIB_PREFIX}",
           "--with-rootrundir=#{CREW_PREFIX}/run",
           "--with-rootlibexecdir=#{CREW_PREFIX}/libexec"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
