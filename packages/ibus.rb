require 'package'

class Ibus < Package
  description 'Next Generation Input Bus for Linux'
  homepage 'https://github.com/ibus/ibus/wiki'
  @_ver = '1.5.25'
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/ibus/ibus.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ibus/1.5.24-1_armv7l/ibus-1.5.24-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ibus/1.5.24-1_armv7l/ibus-1.5.24-1-chromeos-armv7l.tar.xz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ibus/1.5.25_i686/ibus-1.5.25-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ibus/1.5.25_x86_64/ibus-1.5.25-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f12163d784b45e68bbc6c5f844fe3082db1f3c2b3dc621464cc4ac4d81ba2024',
     armv7l: 'f12163d784b45e68bbc6c5f844fe3082db1f3c2b3dc621464cc4ac4d81ba2024',
    i686: 'cef3949b6b3dce1feeab92375135894070585d1aaeb107701c6c2b5e4755795b',
  x86_64: 'ddc0ce92ae7723c87ef3527e47a69684e3ac65b3adb0b2c7fe4cdbf6e9580235'
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
    system "#{CREW_ENV_OPTIONS} ./configure \
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
