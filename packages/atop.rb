require 'package'

class Atop < Package
  description 'ASCII full-screen performance monitor'
  homepage 'https://www.atoptool.nl/'
  version '2.13.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.atoptool.nl/download/atop-#{version}.tar.gz"
  source_sha256 'ea182f84c9f52ca922e5af4f17dff97ff424400a4f2f92393317a6af66e6a874'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ab5216f3406ddf446a57d450fc37b46b0b1e64377eb99dc3320eef30a4737313',
     armv7l: 'ab5216f3406ddf446a57d450fc37b46b0b1e64377eb99dc3320eef30a4737313',
     x86_64: '2675b53c5086f028cb3e41c184f54cfac24c06752e0b7616f44a2939c93fba79'
  })

  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'zlib' => :executable

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
