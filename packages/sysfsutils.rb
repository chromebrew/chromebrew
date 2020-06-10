require 'package'

class Sysfsutils < Package
  description 'These are a set of utilites built upon sysfs, a new virtual filesystem in Linux kernel versions 2.5+ that exposes a system\'s device tree. The current version of sysfsutils includes libsysfs and systool.'
  homepage 'http://linux-diag.sourceforge.net/Sysfsutils.html'
  version '2.1.0'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/linux-diag/files/sysfsutils/2.1.0/sysfsutils-2.1.0.tar.gz'
  source_sha256 'e865de2c1f559fff0d3fc936e660c0efaf7afe662064f2fb97ccad1ec28d208a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sysfsutils-2.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sysfsutils-2.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sysfsutils-2.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sysfsutils-2.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f5cce4169a5647744a583823b0ea095f531574a0fcb11a584207dd871bfef43e',
     armv7l: 'f5cce4169a5647744a583823b0ea095f531574a0fcb11a584207dd871bfef43e',
       i686: '6f7d32bd3a199f8febb2101b368c36da43c5c6363570e020dd66774386ab0288',
     x86_64: '81876c5c17b99ad08b662f0b560021a419c3a441be485963fab688e7fbde6a0b',
  })

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
