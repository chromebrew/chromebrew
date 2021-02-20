require 'package'

class Vte < Package
  description 'Virtual Terminal Emulator widget for use with GTK'
  homepage 'https://wiki.gnome.org/Apps/Terminal/VTE'
  version '0.63.91'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/vte/0.63/vte-0.63.91.tar.xz'
  source_sha256 '2a6f58470148d2a16bac387da12525d061e5984b68fc1ff8d068d10d4f1716ab'

  depends_on 'gobject_introspection' => :build
#  depends_on 'vala' => :build
  depends_on 'fribidi'
  depends_on 'gtk3'
  depends_on 'gtk4'

  def self.patch
    system "sed -i 's/gtk+-4.0/gtk4/g' meson.build"
  end
  
  # i686 headers are too old to have TIOCGPTPEER
  case ARCH
  when 'i686'
    system "sed -i 's/#ifdef __linux__/#ifdef TIOCGPTPEER/' src/pty.cc"
  end
  
  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
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
            builddir" # TODO: get gir and vapi working
    system "ninja -C builddir"
  end
  
  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
