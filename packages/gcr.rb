require 'package'

class Gcr < Package
  description 'GNOME crypto package'
  homepage 'https://www.gnome.org'
  version '3.38.0'
  compatibility 'aarch64,armv7l,x86_64'
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

  def self.build
    system "meson #{CREW_MESON_OPTIONS} build -Dgtk_doc=false"
    system 'meson configure build'
    system 'ninja -v -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
