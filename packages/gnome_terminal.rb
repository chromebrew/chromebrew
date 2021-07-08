require 'package'

class Gnome_terminal < Package
  description 'The GNOME Terminal Emulator'
  homepage 'https://wiki.gnome.org/Apps/Terminal'
  @_ver = '3.41.0-0f6f'
  version @_ver
  license 'GPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-terminal.git'
  git_hashtag '0f6fb3781c2f5efe3306ebe6f41a7e4ba71880db'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_terminal/3.41.0-0f6f_armv7l/gnome_terminal-3.41.0-0f6f-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_terminal/3.41.0-0f6f_armv7l/gnome_terminal-3.41.0-0f6f-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_terminal/3.41.0-0f6f_x86_64/gnome_terminal-3.41.0-0f6f-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '070f952c02e1630e5eb41cf11f5550ccf0c1857201fe688ee37919d7fd293633',
     armv7l: '070f952c02e1630e5eb41cf11f5550ccf0c1857201fe688ee37919d7fd293633',
     x86_64: '5d39201a74bb9a7acd84deaf0be55e94f8207a4c33be4fb065ec17efddda2411'
  })

  depends_on 'gtk3'
  depends_on 'vte'
  depends_on 'dconf'
  depends_on 'desktop_file_utilities'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'yelp_tools'
  depends_on 'gtk_doc'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    --default-library=both \
    -Dsearch_provider=false \
    -Dnautilus_extension=false \
    -Dlocalstatedir=#{CREW_PREFIX}/var/local \
    -Dsharedstatedir=#{CREW_PREFIX}/var/local/lib \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
  end
end
