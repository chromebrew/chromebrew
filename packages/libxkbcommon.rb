require 'package'

class Libxkbcommon < Package
  description 'Keymap handling library for toolkits and window systems'
  homepage 'http:s//xkbcommon.org'
  version '0.8.0'
  source_url 'https://xkbcommon.org/download/libxkbcommon-0.8.0.tar.xz'
  source_sha256 'e829265db04e0aebfb0591b6dc3377b64599558167846c3f5ee5c5e53641fe6d'

  depends_on 'bison'
  depends_on 'libwayland'
  depends_on 'xkeyboard_config'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
