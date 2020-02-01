require 'package'

class Libxcb < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.14'
  source_url 'https://xcb.freedesktop.org/dist/libxcb-1.14.tar.xz'
  source_sha256 'a55ed6db98d43469801262d81dc2572ed124edc3db31059d4e9916eb9f844c34'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcb-1.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxcb-1.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxcb-1.14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcb-1.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bc20a59bdcc53cff12a3b2d6cce84b59a53e9bc1c3d2736cd2be7f4bea3d6758',
     armv7l: 'bc20a59bdcc53cff12a3b2d6cce84b59a53e9bc1c3d2736cd2be7f4bea3d6758',
       i686: '2195bd9b863f56aae744c2eb3729d45340024dfcb1bf25b349024cfd232ce3e3',
     x86_64: '73b4b21814636804c09709e4dc7fd657e097163fb1c7bc395c4cedfa30c3717c',
  })

  depends_on 'python27' => :build
  depends_on 'xcb_proto'
  depends_on 'libxau'
  depends_on 'pthread_stubs'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
