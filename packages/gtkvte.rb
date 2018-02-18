require 'package'

class Gtkvte < Package
  description 'The VTE package contains a termcap file implementation for terminal emulators.'
  homepage 'https://github.com/GNOME/vte'
  version '0.48.3'   # 0.48.3 is the stable version.  Version 0.51.x does not work
  source_url 'https://ftp.gnome.org/pub/gnome/sources/vte/0.48/vte-0.48.3.tar.xz'
  source_sha256 'a3a9fb182740b392a45cd3f46fa61a985f68bb6b1817b52daec22034c46158c3'

  depends_on 'gtk3'
  depends_on 'libxml2'
  depends_on 'pcre2'
  depends_on 'vala'
  depends_on 'gnutls'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "pip install six"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "pip uninstall --yes six"
  end
end
