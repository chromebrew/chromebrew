require 'package'

class Lvm2 < Package
  description 'LVM2 refers to the userspace toolset that provide logical volume management facilities on linux.'
  homepage 'https://sourceware.org/lvm2'
  version '2.02.177'
  source_url 'ftp://sources.redhat.com/pub/lvm2/releases/LVM2.2.02.177.tgz'
  source_sha256 '4025a23ec9b15c2cb7486d151c29dc953b75efc4d452cfe9dbbc7c0fac8e80f2'

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
