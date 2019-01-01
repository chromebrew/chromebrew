require 'package'

class V4l_utils < Package
  description 'The v4l-utils are a series of packages for handling media devices.'
  homepage 'https://www.linuxtv.org/wiki/index.php/V4l-utils'
  version '1.16.3'
  source_url 'https://linuxtv.org/downloads/v4l-utils/v4l-utils-1.16.3.tar.bz2'
  source_sha256 '7c5c0d49c130cf65d384f28e9f3a53c5f7d17bf18740c48c40810e0fbbed5b54'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/v4l_utils-1.16.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/v4l_utils-1.16.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/v4l_utils-1.16.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/v4l_utils-1.16.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c73a40d699272e3526c6e949953f2cd910b67ec4641c2ed17a97945e35c7c6ae',
     armv7l: 'c73a40d699272e3526c6e949953f2cd910b67ec4641c2ed17a97945e35c7c6ae',
       i686: '261ccca7ffd43a12b4085f68ce5f223574bf7300f5f01960bfeb76f12c4fc59b',
     x86_64: 'dc893b16e6fd881d6199b0bf0e6febae1ac36a48b775e0e1e159f07274dd1d14',
  })

  depends_on 'sdl2_image'
  depends_on 'libglu'
  depends_on 'alsa_lib'
  depends_on 'ld_default'

  def self.patch
    system "find . -name '*.pl' -exec sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,g' {} +"
  end

  def self.build
    puts "Forcing GOLD linker to be used.".orange
    original_default = `ld_default g`.chomp
    system "./configure",
           "--disable-bpf",
           "--disable-static",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
    system "ld_default #{original_default}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
