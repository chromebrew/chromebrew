require 'package'

class Flatpak < Package
  description 'Flatpak is a system for building, distributing, and running sandboxed desktop applications on Linux.'
  homepage 'https://flatpak.org'
  @_ver = '1.10.1'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/flatpak/flatpak/releases/download/#{@_ver}/flatpak-#{@_ver}.tar.xz"
  source_sha256 'c70215792b7cbece83c489dab86adc9bfaf9b140c506affe2a48c92afa3d69b7'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/flatpak-1.10.1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/flatpak-1.10.1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/flatpak-1.10.1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/flatpak-1.10.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'c7973f796b3b3b5d3bca1135055eee116589d94f00bedcf7b2784353125c8ddc',
      armv7l: 'c7973f796b3b3b5d3bca1135055eee116589d94f00bedcf7b2784353125c8ddc',
        i686: '2527dd47eef699215e6cfebdb2e5133b936cfc38bdd95a570c6ba8c2df724484',
      x86_64: 'e068889544d79080b12af9bdea43b96b239c54dcc5b48eb511c538e1dd835c26',
  })

  depends_on 'bubblewrap'
  depends_on 'libostree'
  depends_on 'polkit'
  depends_on 'appstream_glib'
  depends_on 'libseccomp'
  depends_on 'pyparsing'

  def self.build
    system 'env NOCONFIGURE=1 ./autogen.sh'
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'  LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --with-system-install-dir=#{CREW_PREFIX}/var/lib/flatpak \
      --enable-sudo \
      --with-priv-mode=setuid \
      --without-systemd \
      --disable-documentation \
      --disable-maintainer-mode \
      --with-system-bubblewrap"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts
    puts 'Configuring flathub'.lightblue
    system 'flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo'
    puts
  end
end
