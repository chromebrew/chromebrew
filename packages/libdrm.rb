require 'package'

class Libdrm < Package
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  version '2.4.82'
  source_url 'https://dri.freedesktop.org/libdrm/libdrm-2.4.82.tar.gz'
  source_sha256 '473997e1fa6f73f75f99bdeb8aa140f7efc3e774988b005c470343ee3cbeb97a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.82-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.82-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.82-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdrm-2.4.82-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b069a4642fdff424ea7468c37e2d49c532a917ac3d0cd1d71ebc3bfd994d7cc8',
     armv7l: 'b069a4642fdff424ea7468c37e2d49c532a917ac3d0cd1d71ebc3bfd994d7cc8',
       i686: 'd6cdcb12ddb38ab9421c44bee208d9e8b03b205b97a58fdff17379d99e81dc4d',
     x86_64: '202a9094a683a76bf352e7c9c6afc1960e6a5f45264e1441006de067ef3191e8',
  })

  depends_on 'libpciaccess'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
