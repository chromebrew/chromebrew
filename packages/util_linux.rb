require 'package'

class Util_linux < Package
  description 'essential linux tools'
  homepage 'https://www.kernel.org'
  version '2.30'
  source_url 'https://www.kernel.org/pub/linux/utils/util-linux/v2.30/util-linux-2.30.tar.xz'
  source_sha256 'c208a4ff6906cb7f57940aa5bc3a6eed146e50a7cc0a092f52ef2ab65057a08d'

  depends_on 'python27'
  depends_on 'vdev'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "sed -i '/chgrp/d' ./Makefile"
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
