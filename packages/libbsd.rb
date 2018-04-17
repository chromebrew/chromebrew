require 'package'

class Libbsd < Package
  description 'This library provides useful functions commonly found on BSD systems, and lacking on others like GNU systems, thus making it easier to port projects with strong BSD origins, without needing to embed the same code over and over again on each project.'
  homepage 'https://libbsd.freedesktop.org/wiki'
  version '0.8.6-0'
  source_url 'https://libbsd.freedesktop.org/releases/libbsd-0.8.6.tar.xz'
  source_sha256 '467fbf9df1f49af11f7f686691057c8c0a7613ae5a870577bef9155de39f9687'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libbsd-0.8.6-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libbsd-0.8.6-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libbsd-0.8.6-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libbsd-0.8.6-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1a72e0121ae61b65ab0852e18d75b99cce9ec388cbc85f6b91abe20b54f0dff3',
     armv7l: '1a72e0121ae61b65ab0852e18d75b99cce9ec388cbc85f6b91abe20b54f0dff3',
       i686: '49ee5262620b910a24ba80bb08d6574e73cbd4da0a661f5e3464228535fdb216',
     x86_64: '26f886a441e46563a0061ede5d0b0e663e76b178ff750120d14da548db26a50d',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
