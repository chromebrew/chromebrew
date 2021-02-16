require 'package'

class Flatpak < Package
  description 'Flatpak is a system for building, distributing, and running sandboxed desktop applications on Linux.'
  homepage 'https://flatpak.org'
  version '1.10.0'
  compatibility 'all'
  source_url 'https://github.com/flatpak/flatpak/releases/download/1.10.1/flatpak-1.10.1.tar.xz'
  source_sha256 'c1354f42bf3b5d51aeb4028c9b62fd4ffc673ef2ff6e583c17777f5dafdbdcb7'

  depends_on 'bubblewrap'
  depends_on 'libostree'
  depends_on 'polkit'
  depends_on 'appstream_glib'
  depends_on 'libseccomp'
  depends_on 'pyparsing'

  def self.build
    system "env NOCONFIGURE=1 ./autogen.sh"
    system "./configure #{CREW_OPTIONS} \
            --with-system-install-dir=/usr/local/var/lib/flatpak \
            --enable-sudo \
            --with-priv-mode=setuid \
            --without-systemd \
            --disable-documentation \
            --disable-maintainer-mode \
            --with-system-bubblewrap"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.postinstall
    puts
    puts "Configuring flathub".lightblue
    system "flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo"
    puts
  end
end