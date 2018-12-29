require 'package'

class V4l_utils < Package
  description 'The v4l-utils are a series of packages for handling media devices.'
  homepage 'https://www.linuxtv.org/wiki/index.php/V4l-utils'
  version '1.16.3'
  source_url 'https://linuxtv.org/downloads/v4l-utils/v4l-utils-1.16.3.tar.bz2'
  source_sha256 '7c5c0d49c130cf65d384f28e9f3a53c5f7d17bf18740c48c40810e0fbbed5b54'

  binary_url ({
  })
  binary_sha256 ({
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
