require 'package'

class Vte < Package
  description 'Virtual Terminal Emulator widget for use with GTK'
  homepage 'https://wiki.gnome.org/Apps/Terminal/VTE'
  version '0.63.91'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/vte/0.63/vte-0.63.91.tar.xz'
  source_sha256 '2a6f58470148d2a16bac387da12525d061e5984b68fc1ff8d068d10d4f1716ab'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vte-0.63.91-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vte-0.63.91-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vte-0.63.91-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vte-0.63.91-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4028b67195f646d4a0e9fef0c3655fe6196339a78c9a9a8ec9e01855d76f9f8d',
     armv7l: '4028b67195f646d4a0e9fef0c3655fe6196339a78c9a9a8ec9e01855d76f9f8d',
       i686: '5a89dfee8af6d95ec42c14d308c760bc0f65bbe3653e1ce0a29a13455a681d6b',
     x86_64: '0d51c8ac7090fb7b427bd963d71ad2b6f47cb459cae447548760973c60dbf7a6'
  })

  depends_on 'gobject_introspection' => ':build'
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
    system "meson \
      #{CREW_MESON_OPTIONS} \
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
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
