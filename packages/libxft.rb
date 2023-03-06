require 'package'

class Libxft < Package
  description 'X.org X FreeType interface library'
  homepage 'https://www.x.org'
  version '2.3.7'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXft-2.3.7.tar.xz'
  source_sha256 '79f0b37c45007381c371a790c2754644ad955166dbf2a48e3625032e9bdd4f71'

  depends_on 'libxrender'
  depends_on 'libx11'
  depends_on 'util_macros'
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
