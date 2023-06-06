require 'package'

class Eudev < Package
  description 'Gentoo standalone udev'
  homepage 'https://wiki.gentoo.org/wiki/Project:Eudev'
  version '3.2.11'
  license 'LGPL-2.1, MIT and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/gentoo/eudev.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eudev/3.2.11_armv7l/eudev-3.2.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eudev/3.2.11_armv7l/eudev-3.2.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eudev/3.2.11_i686/eudev-3.2.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eudev/3.2.11_x86_64/eudev-3.2.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '23041d6ccc617f40fe78e3de297295366f0d4c5fbc8091a2656256f5a7f51c1a',
     armv7l: '23041d6ccc617f40fe78e3de297295366f0d4c5fbc8091a2656256f5a7f51c1a',
       i686: '7c3412817cb76d6277a2cbd16314192fd55e1e230ab02caa76743c591012f1ee',
     x86_64: 'b7c99add75188caaa8cd4f12ebcb06b2e575e2c8f2a8103405aa4b27107d308e'
  })

  depends_on 'acl' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'libxslt' => :build
  depends_on 'util_linux' # R

  def self.patch
    system 'sed -i s,/usr/bin/xsltproc,xsltproc,g man/make.sh'
  end

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "./configure \
              #{CREW_OPTIONS} \
              --enable-hwdb \
              --enable-rule-generator"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
