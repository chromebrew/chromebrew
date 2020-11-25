require 'package'

class Util_linux < Package
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version '2.36.1'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.36/util-linux-2.36.1.tar.xz'
  source_sha256 'd9de3edd287366cd908e77677514b9387b22bc7b88f45b83e1922c3597f1d7f9'

  depends_on 'libcap_ng'
  depends_on 'vdev'
  depends_on 'libtinfo'
  depends_on 'linux_pam'
  depends_on 'pcre2'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-python=3 \
    --enable-fs-paths-extra=#{CREW_PREFIX}/sbin"
    system "sed -i -e '/chgrp/d' -e '/chown/d' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
