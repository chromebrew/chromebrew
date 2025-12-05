require 'package'

class Atop < Package
  description 'ASCII full-screen performance monitor'
  homepage 'https://www.atoptool.nl/'
  version '2.12.1'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.atoptool.nl/download/atop-#{version}.tar.gz"
  source_sha256 '4fdbe67c5dfaf89405639e18599f4eae77978073ffa54f3c78c368ab54bd12f6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '11fb48eec0f39c66d957604479d720fdf26cc6fd76864bc70808469c8832cb8c',
     armv7l: '11fb48eec0f39c66d957604479d720fdf26cc6fd76864bc70808469c8832cb8c',
     x86_64: '0d8ae8ca232411497c9fefe7bb3f855a2e4f651b85c12053f226301ff7fdef7d'
  })

  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'zlib' # R

  def self.patch
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,g' Makefile"
    system "sed -i 's,/usr/sbin,#{CREW_PREFIX}/sbin,g' Makefile"
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,g' Makefile"
    system "sed -i 's,/lib/systemd,#{CREW_PREFIX}/lib/systemd,g' Makefile"
    system "sed -i 's,/usr/lib/,#{CREW_PREFIX}/lib/,g' Makefile"
    system "sed -i 's,/usr/lib64/,#{CREW_LIB_PREFIX}/,g' Makefile"
    system "sed -i 's,/etc/,#{CREW_PREFIX}/etc/,g' Makefile"
    system "sed -i 's,/var/,#{CREW_PREFIX}/var/,g' Makefile"
  end

  def self.build
    system "CFLAGS='-I#{CREW_PREFIX}/include/ncursesw' make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'sysvinstall'
  end
end
