require 'package'

class Gnome_terminal < Package
  description 'The GNOME Terminal Emulator'
  homepage 'https://wiki.gnome.org/Apps/Terminal'
  @_ver = '3.41.0'
  version @_ver
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-terminal.git'
  git_hashtag '3.41.0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_terminal/3.41.0_armv7l/gnome_terminal-3.41.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_terminal/3.41.0_armv7l/gnome_terminal-3.41.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_terminal/3.41.0_x86_64/gnome_terminal-3.41.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a645989d30509d01be54ef794bf8c4f105cef48965c2beb0d05eded71faae724',
     armv7l: 'a645989d30509d01be54ef794bf8c4f105cef48965c2beb0d05eded71faae724',
     x86_64: 'ed42ef2ce74e24a414e978891802fc06cc8cc3c0bb4b9c9dfcd3e71b86b1c0ad'
  })

  depends_on 'gtk3'
  depends_on 'vte'
  depends_on 'dconf'
  depends_on 'desktop_file_utilities'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'adobe_source_code_pro_fonts' # (Needed for monospace fonts)
  depends_on 'yelp_tools'
  depends_on 'gtk_doc'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    --default-library=both \
    -Ddocs=false \
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
