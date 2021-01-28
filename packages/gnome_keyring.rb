require 'package'

class Gnome_keyring < Package
  description 'GNOME password and secret manager'
  homepage 'https://www.gnome.org'
  version '3.36.0-1'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/gnome-keyring/3.36/gnome-keyring-3.36.0.tar.xz'
  source_sha256 'a264b57a8d1a71fdf0d66e8cd6033d013fb828be279c35766545eb9bb3734f87'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_keyring-3.36.0-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_keyring-3.36.0-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_keyring-3.36.0-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_keyring-3.36.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '6d59224375f9d0706112746e1769575009ac2c58d663aa9d92eeb32752aa6d98',
      armv7l: '6d59224375f9d0706112746e1769575009ac2c58d663aa9d92eeb32752aa6d98',
        i686: 'bde76d374b5f47c798115a8e6f4fff5a6b31224c9b8f18caacf4a07b831b94ac',
      x86_64: '9fddad7d70acf21d5a6a2700400762e5b46ebd43413be6cd2db96eba2f9c8048',
  })

  depends_on 'gcr'
  depends_on 'libcap'
  depends_on 'libcap_ng'
  depends_on 'linux_pam'
  depends_on 'dconf'
  depends_on 'gcr'
  depends_on 'docbook_xsl'
  depends_on 'glib'
  depends_on 'libxslt'
  depends_on 'openssh'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
    ./configure #{CREW_OPTIONS} \
    --with-pam-dir=#{CREW_PREFIX}/lib/security \
    --disable-schemas-compile \
    --disable-doc" # Docs cannot be used due to #4275
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
