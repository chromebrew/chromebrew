require 'package'

class Lvm2 < Package
  description 'LVM2 refers to the userspace toolset that provide logical volume management facilities on linux.'
  homepage 'https://sourceware.org/lvm2'
  version '2.02.174'
  source_url 'ftp://sources.redhat.com/pub/lvm2/releases/LVM2.2.02.174.tgz'
  source_sha256 'fb6ecec0408cb14ac4923c87cb0a356481122d7d0ae3fee6e94d2edb9d170a8b'

  depends_on 'readline'

  def self.build
    system "./configure --disable-selinux --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
