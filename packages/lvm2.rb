require 'package'

class Lvm2 < Package
  description 'LVM2 refers to the userspace toolset that provide logical volume management facilities on linux.'
  homepage 'https://sourceware.org/lvm2'
  version '2.02.173'
  source_url 'ftp://sources.redhat.com/pub/lvm2/LVM2.2.02.173.tgz'
  source_sha256 'ceb9168c7e009ef487f96a1fe969b23cbb07d920ffb71769affdbdf30fea8d64'

  def self.build
    system "./configure --disable-selinux --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
