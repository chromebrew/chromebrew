require 'package'

class Eudev < Package
  description 'Gentoo standalone udev'
  homepage 'https://wiki.gentoo.org/wiki/Project:Eudev'
  version '3.2.10-1'
  license 'LGPL-2.1, MIT and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/gentoo/eudev/archive/v3.2.10.tar.gz'
  source_sha256 '6492629da4024d2d21bb1a79d724e013d4152956099a5c63b09c8ee4da7f9b2b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eudev/3.2.10-1_armv7l/eudev-3.2.10-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eudev/3.2.10-1_armv7l/eudev-3.2.10-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eudev/3.2.10-1_i686/eudev-3.2.10-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eudev/3.2.10-1_x86_64/eudev-3.2.10-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '17ff7717448db35fd44096f740cf388d118465fc93e78afc8e2b024252b1e3de',
     armv7l: '17ff7717448db35fd44096f740cf388d118465fc93e78afc8e2b024252b1e3de',
       i686: '635f2019d9b25a18ccf2afdb58d4f853e6f34b177ddcaa9a97a4ca111785a93d',
     x86_64: '27ebf800e0c80b5a60858a19f87416d4e2d3894c568b44178fee366552c9ef5e'
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
