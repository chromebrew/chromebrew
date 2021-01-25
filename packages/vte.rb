require 'package'

class Vte < Package
  description 'Virtual Terminal Emulator widget for use with GTK'
  homepage 'https://wiki.gnome.org/Apps/Terminal/VTE'
  version '0.62.2'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/vte/0.62/vte-0.62.2.tar.xz'
  source_sha256 'b0300bbcf0c02df5812a10a3cb8e4fff723bab92c08c97a0a90c167cf543aff0'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vte-0.62.2-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vte-0.62.2-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/vte-0.62.2-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vte-0.62.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '948e60479e834c4cf9c3fdebab5795faf64c38122d4662f4c355b1068078f743',
      armv7l: '948e60479e834c4cf9c3fdebab5795faf64c38122d4662f4c355b1068078f743',
        i686: '88d7d0d1a8b3e8b86a8ff3c66aa6fc7b1ae8d57712d1659c674bc3b129fd2fcd',
      x86_64: 'f261f381d4ff58761907737037ed60ddafff5444067b38fb28e45f02f04ed6aa',
  })

  depends_on 'gobject_introspection' => ':build'
  depends_on 'icu4c'
  depends_on 'fribidi'
  depends_on 'gtk3'
  depends_on 'gtk4'

  def self.patch
  system "sed -i 's/gtk+-4.0/gtk4/g' meson.build"
  
  # i686 headers are too old to have TIOCGPTPEER
  case ARCH
  when 'i686'
    system "sed -i 's/#ifdef __linux__/#ifdef TIOCGPTPEER/' src/pty.cc"
  end
  end
  
  def self.build
  system "unset CFLAGS && meson setup #{CREW_MESON_OPTIONS} \
    -Dc_args='-fuse-ld=lld -pipe -fno-stack-protector' \
    -Dc_link_args='-fuse-ld=lld -pipe -fno-stack-protector' \
    -Dcpp_args='-fuse-ld=lld -pipe -fno-stack-protector' \
    -Dcpp_link_args='-fuse-ld=lld -pipe -fno-stack-protector' \
    -D_systemd=false \
    -Dfribidi=true \
    -Dgtk3=true \
    -Dgtk4=true \
    -Dgir=false \
    -Dvapi=false \
    builddir"
  system "meson configure builddir"
  system "ninja -C builddir"
  end
  
  def self.install
  system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
