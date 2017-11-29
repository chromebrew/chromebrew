require 'package'

class Attr < Package
  description 'Commands for Manipulating Filesystem Extended Attributes.'
  homepage 'http://savannah.nongnu.org/projects/attr'
  version '2.4.47-1'
  source_url 'http://download.savannah.gnu.org/releases/attr/attr-2.4.47.src.tar.gz'
  source_sha256 '25772f653ac5b2e3ceeb89df50e4688891e21f723c460636548971652af0a859'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/attr-2.4.47-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/attr-2.4.47-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/attr-2.4.47-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/attr-2.4.47-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0d973ff3629a90424987fd16e19f3636a6f6d0b607ba3f611db7f226d36b3b9d',
     armv7l: '0d973ff3629a90424987fd16e19f3636a6f6d0b607ba3f611db7f226d36b3b9d',
       i686: '9631985d3743414faaeccfa054c7c776efe0bf61b77c9fca767c1d6dc9ac3786',
     x86_64: '427417c434bf8bc12cbb49f7b25b34615f51be48738346cba3f40c3c62937b3f',
  })

  depends_on 'gettext'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-dev"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-lib"
  end
end
