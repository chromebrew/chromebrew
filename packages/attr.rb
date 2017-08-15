require 'package'

class Attr < Package
  description 'Commands for Manipulating Filesystem Extended Attributes.'
  homepage 'http://savannah.nongnu.org/projects/attr'
  version '2.4.47'
  source_url 'http://download.savannah.gnu.org/releases/attr/attr-2.4.47.src.tar.gz'
  source_sha256 '25772f653ac5b2e3ceeb89df50e4688891e21f723c460636548971652af0a859'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/attr-2.4.47-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/attr-2.4.47-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/attr-2.4.47-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/attr-2.4.47-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '082b73f0a150d15c3c9648ad28295f01ac73424c8d32d9b6cda8b7337954dc7c',
     armv7l: '082b73f0a150d15c3c9648ad28295f01ac73424c8d32d9b6cda8b7337954dc7c',
       i686: 'da6b9cd56ea0f0bc4396fb5db5ecb6056b1e09d5a678d8e3cce6f28bf6c7ed2d',
     x86_64: '1b941d8dc1f5bc0bb810d28b9db1c6e93422e961169c603c09d10ba14e7afe49',
  })

  depends_on 'gettext'

  def self.build
    system "./configure --prefix=/usr/local --disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-dev"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-lib"
  end
end
