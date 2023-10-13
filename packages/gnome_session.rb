require 'package'

class Gnome_session < Package
  description 'The GNOME Session Handler'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-session'
  version '43.0'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gnome-session/-/archive/#{version}/gnome-session-#{version}.tar.bz2"
  source_sha256 'a56b5a4179e4e567fb360e98ae1a1b8b8e3deed8fb0ff66d3f343e4623f59f3c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_session/43.0_armv7l/gnome_session-43.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_session/43.0_armv7l/gnome_session-43.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_session/43.0_i686/gnome_session-43.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_session/43.0_x86_64/gnome_session-43.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f15e68a01de854d8d373b4632ccc2ff4c928288b3945cbc804972fb54e0f6d9f',
     armv7l: 'f15e68a01de854d8d373b4632ccc2ff4c928288b3945cbc804972fb54e0f6d9f',
       i686: '7604da967a83dcd89a6c5a125ea0ef4863e17e6c6d09461e32890dcd54f63049',
     x86_64: 'f4ed165ccdfc333ea3caf0d21ff8ab7610860af818b7bd4b6eac105f6dc97766'
  })

  depends_on 'elogind'
  depends_on 'dconf'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'gtk3'
  depends_on 'gnome_desktop'
  depends_on 'mesa' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'libxtrans' => :build
  depends_on 'xmlto' => :build
  depends_on 'docbook_xsl' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'json_glib' # R
  depends_on 'libepoxy' # R
  depends_on 'libglvnd' # R
  depends_on 'libice' # R
  depends_on 'libsm' # R
  depends_on 'libx11' # R
  depends_on 'libxcomposite' # R
  depends_on 'mesa' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS}\
      -Dsystemd=false \
      -Dsystemd_session=disable \
      -Dsystemd_journal=false \
      builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
