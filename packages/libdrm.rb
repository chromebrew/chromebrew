require 'package'

class Libdrm < Package
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  version '2.4.82'
  source_url 'https://dri.freedesktop.org/libdrm/libdrm-2.4.82.tar.gz'
  source_sha256 '473997e1fa6f73f75f99bdeb8aa140f7efc3e774988b005c470343ee3cbeb97a'

  depends_on 'libpciaccess'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
