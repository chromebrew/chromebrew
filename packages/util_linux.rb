require 'package'

class Util_linux < Package
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version '2.35.1'
  source_url 'https://kernel.org/pub/linux/utils/util-linux/v2.35/util-linux-2.35.1.tar.xz'
  source_sha256 'd9de3edd287366cd908e77677514b9387b22bc7b88f45b83e1922c3597f1d7f9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.35.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.35.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.35.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/util_linux-2.35.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ff43f032e650b280007e5717cda2fee20dca97ff731b6e4168ceeea251f93281',
     armv7l: 'ff43f032e650b280007e5717cda2fee20dca97ff731b6e4168ceeea251f93281',
       i686: 'e39aa402ff8679b68b761c4f41554f2e9cdcd688bd6b23f40c5bc54a26c1e864',
     x86_64: '7b4ab11425c7e70d4addf48a71048fcd89197899cae254ee4e6cdbdccc93eed1',
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
