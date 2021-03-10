require 'package'

class Ibus < Package
  description 'Next Generation Input Bus for Linux'
  homepage 'https://github.com/ibus/ibus/wiki'
  @_ver = '1.5.24'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/ibus/ibus/releases/download/#{@_ver}/ibus-#{@_ver}.tar.gz"
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ibus-1.5.24-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ibus-1.5.24-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ibus-1.5.24-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ibus-1.5.24-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '5bc9429dff55a5b81418d29168b724d5b3a828742ddc8862c603ac5427a53705',
     armv7l: '5bc9429dff55a5b81418d29168b724d5b3a828742ddc8862c603ac5427a53705',
       i686: '197cc0876e47976e0fce6a628adc8782ddbbf7dbd047f4a08f84be8456307566',
     x86_64: '9443bc2b1285cb3588c0aabadbf71b0c08800df28ff6d808ff05aaa8bec6364a'
  })

  depends_on 'dconf'
  depends_on 'gtk3'
  depends_on 'gtk4'
  depends_on 'hicolor_icon_theme'
  depends_on 'libnotify'
  depends_on 'pygobject'
  depends_on 'unicode_emoji'
  depends_on 'unicode_cldr'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'vala' => ':build'
  depends_on 'gnome_common' => ':build'
  depends_on 'gtk_doc' => ':build'
  depends_on 'gtk2' => ':build'
  depends_on 'qtbase' => ':build'

  def self.patch
    system "sed -i 's|/usr/bin/python|#{CREW_PREFIX}/bin/python3|' engine/gensimple.py"
    system "sed -i 's|/usr/bin/python|#{CREW_PREFIX}/bin/python3|' engine/iso639converter.py"
    system "sed -i 's|\$(libibus) \$(libibus_emoji_dialog)|\$(libibus_emoji_dialog) \$(libibus)|' ui/gtk3/Makefile.am"
  end

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system './configure --help'
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
