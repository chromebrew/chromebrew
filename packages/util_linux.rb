require 'package'

class Util_linux < Package
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version '2.34'
  source_url 'https://kernel.org/pub/linux/utils/util-linux/v2.34/util-linux-2.34.tar.xz'
  source_sha256 '743f9d0c7252b6db246b659c1e1ce0bd45d8d4508b4dfa427bbb4a3e9b9f62b5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.34-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.34-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.34-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.34-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '806848160db052933921a25eebb0772ff258f5e87ac58b3d932fce0a5acada82',
     armv7l: '806848160db052933921a25eebb0772ff258f5e87ac58b3d932fce0a5acada82',
       i686: 'f900818913f0a3f0396db7713ad99093af6fea2fd5a4d3e3131ac2ed60e845cd',
     x86_64: 'f3bbcda8e4c87a20fc3fb6f12766af439bd30f931bd6e2a3f450cbdbed3bc084',
  })

  depends_on 'python27'
  depends_on 'libcap_ng'
  depends_on 'vdev'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system "sed -i -e '/chgrp/d' -e '/chown/d' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
