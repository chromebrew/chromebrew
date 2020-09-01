require 'package'

class Libfontenc < Package
  description 'Fontenc Library from X.org'
  homepage 'https://xorg.freedesktop.org/'
  version '1.1.4'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/lib/libfontenc-1.1.4.tar.bz2'
  source_sha256 '2cfcce810ddd48f2e5dc658d28c1808e86dcf303eaff16728b9aa3dbc0092079'

  depends_on 'xorg_proto'
  depends_on 'zlibpkg'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-fontrootdir=#{CREW_PREFIX}/share/fonts/X11"
    system "make -j#{CREW_NPROC}"
  end
  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
