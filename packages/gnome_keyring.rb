require 'package'

class Gnome_keyring < Package
  description 'GNOME password and secret manager'
  homepage 'https://www.gnome.org'
  version '3.36.0'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/gnome-keyring/3.36/gnome-keyring-3.36.0.tar.xz'
  source_sha256 'a264b57a8d1a71fdf0d66e8cd6033d013fb828be279c35766545eb9bb3734f87'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_keyring-3.36.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_keyring-3.36.0-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_keyring-3.36.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a274265a95ebb7f2519476673da11d438b8996bcdd38ac64064aa1cbda594f92',
     armv7l: 'a274265a95ebb7f2519476673da11d438b8996bcdd38ac64064aa1cbda594f92',
     x86_64: 'ce2df2cef40f9b97903e2695c519f9b5e3c0f25fdc3f0cb399515d3463e92d6b',
  })

  depends_on 'gcr'
  depends_on 'libcap'
  depends_on 'libcap_ng'
  depends_on 'openpam'
  depends_on 'dconf'
  depends_on 'gcr'
  depends_on 'docbook_xsl'
  depends_on 'glib'
  depends_on 'libxslt'
  depends_on 'openssh'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-pam-dir=#{CREW_PREFIX}/lib/security --disable-schemas-compile --disable-doc" # Docs cannot be used due to #4275
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
