require 'package'

class Alsa_lib < Package
  description 'The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.1.4.1'
  source_url 'ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.1.4.1.tar.bz2'
  source_sha256 '91bb870c14d1c7c269213285eeed874fa3d28112077db061a3af8010d0885b76'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.1.4.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.1.4.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.1.4.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_lib-1.1.4.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5376a7866ef12749e5b5d4037803a042fa3e4088d910bd0adf163c185af3a0e6',
     armv7l: '5376a7866ef12749e5b5d4037803a042fa3e4088d910bd0adf163c185af3a0e6',
       i686: 'ed722bb503215b3f442683a3a23a26bd045a129c645920fb9562ab3a3d7797ef',
     x86_64: '9c68c55716c8415d13834a00926f4a0b48d3e16d2cd5d3c64913e64b03c16e55',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
