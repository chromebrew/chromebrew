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
    aarch64: 'e3fe61432a57a25854cd9ca11376a53fcd4d06cec021be8f19dc115c50d88ca0',
     armv7l: 'e3fe61432a57a25854cd9ca11376a53fcd4d06cec021be8f19dc115c50d88ca0',
     x86_64: 'a1e29ea81461c265548f2e71435d63c90165034221fd0cc7eaaf357fb337ee5f'
  })

  depends_on 'glib' # R
  depends_on 'glibc' # R

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
