
require 'package'

class Libxinerama < Package
  description 'Xorg library, Xinerama is an X11 extension which provides support for extending a desktop across multiple displays.'
  homepage 'https://www.x.org/'
  compatibility 'all'
  version '1.1.3-1'
  source_url 'https://www.x.org/archive//individual/lib/libXinerama-1.1.3.tar.gz'
  source_sha256 '0ba243222ae5aba4c6a3d7a394c32c8b69220a6872dbb00b7abae8753aca9a44'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxinerama-1.1.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxinerama-1.1.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxinerama-1.1.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxinerama-1.1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0ad8a511d0955f8cfcb767174c4ee55f4203a47a95f4281d9f2717a1b3147322',
     armv7l: '0ad8a511d0955f8cfcb767174c4ee55f4203a47a95f4281d9f2717a1b3147322',
       i686: '5e909ef4db126d972af64310b8ce806deb60f95b21406393f01a1f8e99b21a59',
     x86_64: '73f25bf7cf51787d00e2fbe46cf6589e321c465333e8d2c9dc3d97bfa93a70da',
  })

  depends_on 'libx11'
  depends_on 'libxcb'
  depends_on 'libxext'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
