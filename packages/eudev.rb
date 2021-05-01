require 'package'

class Eudev < Package
  description 'Gentoo standalone udev'
  homepage 'https://wiki.gentoo.org/wiki/Project:Eudev'
  version '3.2.9'
  license 'LGPL-2.1, MIT and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/gentoo/eudev/archive/v3.2.9.tar.gz'
  source_sha256 '7d281276b480da3935d1acb239748c2c9db01a8043aad7e918ce57a223d8cd24'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eudev/3.2.9_armv7l/eudev-3.2.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eudev/3.2.9_armv7l/eudev-3.2.9-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eudev/3.2.9_i686/eudev-3.2.9-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eudev/3.2.9_x86_64/eudev-3.2.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '014949c46459aca47f5a28e71c01e55ef075cda8f8a00a35dbb3fec924dbcdeb',
     armv7l: '014949c46459aca47f5a28e71c01e55ef075cda8f8a00a35dbb3fec924dbcdeb',
       i686: '9702fec818cda9719b72e98e1421a151665a3e1f6a06d54ba427ce286d6ad065',
     x86_64: '8bfd928443202d834e78e5eea5b7325dcd47e04126cbfb96f61e6e8a30c61f7d',
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
