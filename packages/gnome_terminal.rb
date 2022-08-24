require 'package'

class Gnome_terminal < Package
  description 'The GNOME Terminal Emulator'
  homepage 'https://wiki.gnome.org/Apps/Terminal'
  @_ver = '3.45.90'
  version @_ver
  license 'GPL-3+'
  compatibility 'x86_64 armv7l aarch64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-terminal.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_terminal/3.45.90_armv7l/gnome_terminal-3.45.90-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_terminal/3.45.90_armv7l/gnome_terminal-3.45.90-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_terminal/3.45.90_x86_64/gnome_terminal-3.45.90-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '88f445c929da22ee4ae71dae62c0ac1ee7fbe6ad226f4b29271612e6afbec5c2',
     armv7l: '88f445c929da22ee4ae71dae62c0ac1ee7fbe6ad226f4b29271612e6afbec5c2',
     x86_64: 'a94bc8f5bf868dbb1134e02a9af01e1b188a97f786cfeeb656d00401e467552a'
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
