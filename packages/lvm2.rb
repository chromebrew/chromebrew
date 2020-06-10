require 'package'

class Lvm2 < Package
  description 'LVM2 refers to the userspace toolset that provide logical volume management facilities on linux.'
  homepage 'https://sourceware.org/lvm2'
  version '2.02.176'
  compatibility 'all'
  source_url 'ftp://sources.redhat.com/pub/lvm2/releases/LVM2.2.02.176.tgz'
  source_sha256 'dece83628c2c78a267a126ce6046d506582185ae5d40fb8d59b56547fccea473'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lvm2-2.02.176-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lvm2-2.02.176-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lvm2-2.02.176-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lvm2-2.02.176-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '10d5b009661b35da06702fe1cf767fff414acd934caa4824d72351f7f3dad95f',
     armv7l: '10d5b009661b35da06702fe1cf767fff414acd934caa4824d72351f7f3dad95f',
       i686: '81139a176ca219e7fa1b8a4bc6977a673c4225641d05009f3017ad563bf5ce4a',
     x86_64: '62ae341a5d0120f03ec7d33db3fbe1a0e93d25717223c0f68f8f319bf9274da3',
  })

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
