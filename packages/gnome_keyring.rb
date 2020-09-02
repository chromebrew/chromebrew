require 'package'

class Gnome_keyring < Package
  description 'GNOME password and secret manager'
  homepage 'https://www.gnome.org'
  version '3.36.0'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/gnome-keyring/3.36/gnome-keyring-3.36.0.tar.xz'
  source_sha256 'a264b57a8d1a71fdf0d66e8cd6033d013fb828be279c35766545eb9bb3734f87'

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

  def self.builds
      system "./configure #{CREW_OPTIONS} --with-pam-dir=#{CREW_PREFIX}/lib/security --disable-schemas-compile --disable-doc" # Docs cannot be used due to #4275
      system "make -j#{CREW_NPROC}"
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
