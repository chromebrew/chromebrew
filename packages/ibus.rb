require 'buildsystems/autotools'

class Ibus < Autotools
  description 'Next Generation Input Bus for Linux'
  homepage 'https://github.com/ibus/ibus/wiki'
  version '1.5.30-rc1'
  license 'LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/ibus/ibus.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bb9f81191d52c9b1980f1a9a2eb6d6802aaea488815d327a89eff72b02a3fff8',
     armv7l: 'bb9f81191d52c9b1980f1a9a2eb6d6802aaea488815d327a89eff72b02a3fff8',
     x86_64: 'd16c5dc798a4faa30e9dc3d0aad65127cbe01ef0639df54d6ab1786600619609'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'dbus' # R
  depends_on 'dconf' # R
  depends_on 'fontconfig' => :build
  depends_on 'freetype' => :build
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gnome_common' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' # R
  depends_on 'gtk3' # R
  depends_on 'gtk4' # R
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'hicolor_icon_theme' => :build
  depends_on 'iso_codes' => :build
  depends_on 'libbsd' # R
  depends_on 'libnotify' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxi' # R
  depends_on 'libxkbcommon' # R
  depends_on 'pango' # R
  depends_on 'pygobject' => :build
  depends_on 'qt5_base' => :build
  depends_on 'unicode_cldr' => :build
  depends_on 'unicode_emoji' => :build
  depends_on 'vala' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # R
  depends_on 'wayland' # R
  depends_on 'zlibpkg' # R

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
    --disable-gtk2 \
    --disable-memconf \
    --disable-python2 \
    --disable-systemd-services \
    --enable-dconf \
    --enable-gtk4 \
    --enable-ui \
    --enable-wayland \
    --with-unicode-emoji-dir=#{CREW_PREFIX}/share/unicode/emoji \
    --with-emoji-annotation-dir=#{CREW_PREFIX}/share/unicode/cldr/common/annotations \
    --with-python=python3 \
    --with-ucd-dir=#{CREW_PREFIX}/share/unicode"
end
