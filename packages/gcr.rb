require 'package'

class Gcr < Package
  description 'GNOME crypto package'
  homepage 'https://www.gnome.org'
  version '3.38.0'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    source_url 'https://download.gnome.org/sources/gcr/3.38/gcr-3.38.0.tar.xz'
    source_sha256 'a64cc7b65757fc2cd16de1708d132a16d05cd1f62c6eba436d56fe45d4ba27e1'
    depends_on 'libgcrypt'
    depends_on 'libxslt'
    depends_on 'desktop_file_utilities'
    depends_on 'hicolor_icon_theme'
    depends_on 'gnupg'
    depends_on 'glib'
    depends_on 'gnupg'
    depends_on 'libxslt'
    depends_on 'vala' => :build
    depends_on 'gtk3'
    depends_on 'graphite'
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gcr-3.38.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gcr-3.38.0-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gcr-3.38.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'de66b71446151441ac30d62cf29e92009a999370dda3e4ad5b08ecdb0441eda6',
     armv7l: 'de66b71446151441ac30d62cf29e92009a999370dda3e4ad5b08ecdb0441eda6',
     x86_64: '3690fa506949ac8b4ee9ebe189d751086f945d782993ef80777fe6ac0d6ccb9f',
  })

  def self.build
    system "meson #{CREW_MESON_OPTIONS} build -Dgtk_doc=false"
    system 'meson configure build'
    system 'ninja -v -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
