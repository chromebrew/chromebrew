require 'package'

class Eudev < Package
  description 'Gentoo standalone udev'
  homepage 'https://wiki.gentoo.org/wiki/Project:Eudev'
  version '3.2.10'
  license 'LGPL-2.1, MIT and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/gentoo/eudev/archive/v3.2.9.tar.gz'
  source_sha256 '7d281276b480da3935d1acb239748c2c9db01a8043aad7e918ce57a223d8cd24'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eudev/3.2.10_armv7l/eudev-3.2.10-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eudev/3.2.10_armv7l/eudev-3.2.10-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eudev/3.2.10_i686/eudev-3.2.10-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eudev/3.2.10_x86_64/eudev-3.2.10-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '4d85f88d4c269d44becb65bb4dbb63972b77d8b55e6991afe948d3a6fb24de59',
     armv7l: '4d85f88d4c269d44becb65bb4dbb63972b77d8b55e6991afe948d3a6fb24de59',
       i686: 'f735c42d484d51b473b081ec94750aeeb29cd734e93b18022940415e19fed686',
     x86_64: '8e4ac5c8fec1f497813ea56f6c96aeb9aba50a4182f576c4c2125a4df2587245'
  })

  depends_on 'libxslt'
  depends_on 'gperf'
  depends_on 'util_linux'

  def self.patch
    system 'sed -i s,/usr/bin/xsltproc,xsltproc,g man/make.sh'
  end
  
  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "#{CREW_ENV_OPTIONS} ./configure \
              #{CREW_OPTIONS} \
              --enable-hwdb \
              --enable-rule-generator"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
