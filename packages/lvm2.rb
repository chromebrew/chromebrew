require 'package'

class Lvm2 < Package
  description 'LVM2 refers to the userspace toolset that provide logical volume management facilities on linux.'
  homepage 'https://sourceware.org/lvm2'
  version '2.02.176'
  source_url 'ftp://sources.redhat.com/pub/lvm2/releases/LVM2.2.02.176.tgz'
  source_sha256 'dece83628c2c78a267a126ce6046d506582185ae5d40fb8d59b56547fccea473'

  depends_on 'readline'

  def self.build
    system "./configure \
            --disable-selinux \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --with-confdir=#{CREW_PREFIX}/etc"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
