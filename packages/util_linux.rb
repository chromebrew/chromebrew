require 'package'

class Util_linux < Package
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version '2.35.1'
  source_url 'https://kernel.org/pub/linux/utils/util-linux/v2.35/util-linux-2.35.1.tar.xz'
  source_sha256 'd9de3edd287366cd908e77677514b9387b22bc7b88f45b83e1922c3597f1d7f9'

  binary_url ({
  })
  binary_sha256 ({
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
