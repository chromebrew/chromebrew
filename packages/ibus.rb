require 'package'

class Ibus < Package
  description 'Next Generation Input Bus for Linux'
  homepage 'https://github.com/ibus/ibus/wiki'
  @_ver = '1.5.24'
  version "#{@_ver}-1"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://github.com/ibus/ibus/releases/download/#{@_ver}/ibus-#{@_ver}.tar.gz"
  source_sha256 'abf33a965063629d3bbdab8a5948736ce3a9523cc3d6331e5ea0ec5e8ea7421f'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/ibus-1.5.24-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/ibus-1.5.24-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/ibus-1.5.24-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/ibus-1.5.24-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f12163d784b45e68bbc6c5f844fe3082db1f3c2b3dc621464cc4ac4d81ba2024',
     armv7l: 'f12163d784b45e68bbc6c5f844fe3082db1f3c2b3dc621464cc4ac4d81ba2024',
       i686: '683dd8cd21854a8a47a66e3d3c238cc898d22745f48390c28483ef16fdfecd40',
     x86_64: 'baeca79b3d8750e062e46dcee2114f3425a8abed1a104db540df542ea098814f'
  })

  depends_on 'atk'
  depends_on 'cairo'
  depends_on 'dconf'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'graphene'
  depends_on 'harfbuzz'
  depends_on 'hicolor_icon_theme'
  depends_on 'libnotify'
  depends_on 'libx11'
  depends_on 'libxi'
  depends_on 'pango'
  depends_on 'pygobject'
  depends_on 'unicode_cldr'
  depends_on 'unicode_emoji'
  depends_on 'vulkan_icd_loader'
  depends_on 'wayland'
  depends_on 'gobject_introspection' => :build
  depends_on 'vala' => :build
  depends_on 'gnome_common' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'gtk2' => :build
  depends_on 'gtk3' => :build
  depends_on 'gtk4' => :build
  depends_on 'qtbase' => :build

  def self.patch
    system "sed -i 's|/usr/bin/python|#{CREW_PREFIX}/bin/python3|' engine/gensimple.py"
    system "sed -i 's|/usr/bin/python|#{CREW_PREFIX}/bin/python3|' engine/iso639converter.py"
    system "sed -i 's|\$(libibus) \$(libibus_emoji_dialog)|\$(libibus_emoji_dialog) \$(libibus)|' ui/gtk3/Makefile.am"
  end

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "env CFLAGS='-flto=auto' \
    CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
    ./configure \
    #{CREW_OPTIONS} \
    --libexecdir=#{CREW_LIB_PREFIX}/ibus \
    --sysconfdir=#{CREW_PREFIX}/etc \
    --enable-dconf \
    --enable-wayland \
    --enable-gtk4 \
    --disable-memconf \
    --enable-ui \
    --disable-python2 \
    --with-unicode-emoji-dir=#{CREW_PREFIX}/share/unicode/emoji \
    --with-emoji-annotation-dir=#{CREW_PREFIX}/share/unicode/cldr/common/annotations \
    --with-python=python3 \
    --with-ucd-dir=#{CREW_PREFIX}/share/unicode"
    unless File.exist?('engine/denylist.txt')
      system "curl -Lf https://github.com/ibus/ibus/raw/#{@_ver}/engine/denylist.txt -o engine/denylist.txt"
    end
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
