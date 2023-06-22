require 'package'

class Ibus < Package
  description 'Next Generation Input Bus for Linux'
  homepage 'https://github.com/ibus/ibus/wiki'
  version '1.5.28'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/ibus/ibus.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ibus/1.5.28_armv7l/ibus-1.5.28-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ibus/1.5.28_armv7l/ibus-1.5.28-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ibus/1.5.28_i686/ibus-1.5.28-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ibus/1.5.28_x86_64/ibus-1.5.28-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0da10f4284f8f9f53120eb73da5310f7467038e33f68537bf5f247fd85df3778',
     armv7l: '0da10f4284f8f9f53120eb73da5310f7467038e33f68537bf5f247fd85df3778',
       i686: '802e477595ac64a073a9eda3811cd1aa31c9a6e9c93cee36e5ca22e07aa8ed63',
     x86_64: '85e9181167b7238411d198bff3f673d40693b8391e0dd1a4cc1bbaaa4ce02303'
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
    --disable-systemd-services \
    --with-unicode-emoji-dir=#{CREW_PREFIX}/share/unicode/emoji \
    --with-emoji-annotation-dir=#{CREW_PREFIX}/share/unicode/cldr/common/annotations \
    --with-python=python3 \
    --with-ucd-dir=#{CREW_PREFIX}/share/unicode"
    unless File.exist?('engine/denylist.txt')
      downloader "https://github.com/ibus/ibus/raw/#{version}/engine/denylist.txt",
                 '8589b87200d2e7dbf8a413129270d678e83b727bb5b7f8607e62cb9e40d2fdf1'
    end
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
