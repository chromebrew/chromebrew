require 'package'

class V4l_utils < Package
  description 'The v4l-utils are a series of packages for handling media devices.'
  homepage 'https://www.linuxtv.org/wiki/index.php/V4l-utils'
  version '1.18.0'
  source_url 'https://linuxtv.org/downloads/v4l-utils/v4l-utils-1.18.0.tar.bz2'
  source_sha256 '6cb60d822eeed20486a03cc23e0fc65956fbc1e85e0c1a7477f68bbd9802880d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/v4l_utils-1.18.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/v4l_utils-1.18.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/v4l_utils-1.18.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/v4l_utils-1.18.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'baf11b08999b753b4b874b5fd5eebecb85f78679f0912350bffc8a27c558dc08',
     armv7l: 'baf11b08999b753b4b874b5fd5eebecb85f78679f0912350bffc8a27c558dc08',
       i686: '8c12cad6c323d2448c6dcb9b8c68c6b1c5aea6889c1c99fdbeea616529e8d38a',
     x86_64: '17414e347092d411b24c3caa5f306f881996b639435c82d1a7aac9d693aa64d2',
  })

  depends_on 'sdl2_image'
  depends_on 'libglu'
  depends_on 'alsa_lib'
  depends_on 'ld_default'

  def self.patch
    system "find . -name '*.pl' -exec sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,g' {} +"
  end

  def self.build
    puts 'Switch to the gold linker.'.orange
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
