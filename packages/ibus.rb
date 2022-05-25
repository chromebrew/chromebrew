require 'buildsystems/autotools'

class Ibus < Autotools
  description 'Next Generation Input Bus for Linux'
  homepage 'https://github.com/ibus/ibus/wiki'
  version '1.5.29'
  license 'LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/ibus/ibus.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ibus/1.5.29_armv7l/ibus-1.5.29-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ibus/1.5.29_armv7l/ibus-1.5.29-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ibus/1.5.29_x86_64/ibus-1.5.29-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fbb28b276b71eebc03c119fcfbd1759fce8b14c89b710aba4c420f0f29203f4b',
     armv7l: 'fbb28b276b71eebc03c119fcfbd1759fce8b14c89b710aba4c420f0f29203f4b',
     x86_64: '942b4c9e86c82eda6a6e49856377b53c83e9036fad2606e3c5b62ef0cf100083'
  })

  depends_on 'at_spi2_core'
  depends_on 'cairo'
  depends_on 'dconf'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'graphene'
  depends_on 'harfbuzz'
  depends_on 'hicolor_icon_theme'
  depends_on 'iso_codes'
  depends_on 'libdbusmenu_gtk3'
  depends_on 'libnotify'
  depends_on 'libx11'
  depends_on 'libxi'
  depends_on 'pango'
  depends_on 'pygobject'
  depends_on 'unicode_cldr'
  depends_on 'unicode_emoji'
  depends_on 'vulkan_headers'
  depends_on 'vulkan_icd_loader'
  depends_on 'wayland'
  depends_on 'gobject_introspection' => :build
  depends_on 'vala' => :build
  depends_on 'gnome_common' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'gtk2' => :build
  depends_on 'gtk3' => :build
  depends_on 'gtk4' => :build
  depends_on 'qt5_base' => :build

  def self.patch
    system "sed -i 's|/usr/bin/python|#{CREW_PREFIX}/bin/python3|' engine/gensimple.py"
    system "sed -i 's|/usr/bin/python|#{CREW_PREFIX}/bin/python3|' engine/iso639converter.py"
    system "sed -i 's|\$(libibus) \$(libibus_emoji_dialog)|\$(libibus_emoji_dialog) \$(libibus)|' ui/gtk3/Makefile.am"
  end

  def self.prebuild
    unless File.exist?('engine/denylist.txt')
      downloader "https://github.com/ibus/ibus/raw/#{version}/engine/denylist.txt",
                 '8589b87200d2e7dbf8a413129270d678e83b727bb5b7f8607e62cb9e40d2fdf1'
    end
  end

  configure_options "--libexecdir=#{CREW_LIB_PREFIX}/ibus \
    --sysconfdir=#{CREW_PREFIX}/etc \
    --enable-dconf \
    --enable-wayland \
    --enable-gtk4 \
    --disable-memconf \
    --enable-ui \
    --disable-python2 \
    --disable-systemd-services \
    --with-unicode-emoji-dir=#{CREW_PREFIX}/share/unicode/emoji \
    --with-emoji-annotation-dir=#{CREW_PREFIX}/share/unicode/cldr/common/annotations \
    --with-python=python3 \
    --without-systemd \
    --with-ucd-dir=#{CREW_PREFIX}/share/unicode"
end
