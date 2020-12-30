require 'package'

class Homebank < Package
  description 'HomeBank is a free software that will assist you to manage your personal accounting.'
  homepage 'http://homebank.free.fr/en/index.php'
  version '5.2.4'
  compatibility 'all'
  source_url 'http://homebank.free.fr/public/homebank-5.2.4.tar.gz'
  source_sha256 '79a89ab8816a5973fa6afe75157fa375953795c79c224d510e8af0afed2512d2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/homebank-5.2.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/homebank-5.2.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/homebank-5.2.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/homebank-5.2.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b01261bab43f81e1d89f82a85a26bdd39c5ede81a7dfda5d9c95fec8ee8f5c83',
     armv7l: 'b01261bab43f81e1d89f82a85a26bdd39c5ede81a7dfda5d9c95fec8ee8f5c83',
       i686: '887e298a2aae9b2d6f95a5745124ab8ab6745d18032195c32a5c05c9dea7b997',
     x86_64: '5d609a527c5b8cb12d4c42440ad3f87eb3ad1d13de20025f04a3c31cd1a2a18d',
  })

  depends_on 'libofx'
  depends_on 'libsoup'
  depends_on 'gtk3'
  depends_on 'xdg_base'
  depends_on 'wayland_protocols'
  depends_on 'mesa'
  depends_on 'xcb_util'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    FileUtils.mv '#{CREW_DEST_PREFIX}/bin/homebank', '#{CREW_DEST_PREFIX}/bin/homebank_orig'
    system "cat <<'EOF'> homebank
WAYLAND_DISPLAY=wayland-0
GDK_BACKEND=wayland
DISPLAY=
#{CREW_PREFIX}/bin/homebank_orig $@
EOF"
    system "install -Dm755 homebank #{CREW_DEST_PREFIX}/bin/homebank"
  end
end
