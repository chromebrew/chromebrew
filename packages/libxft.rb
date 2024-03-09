require 'package'

class Libxft < Package
  description 'X.org X FreeType interface library'
  homepage 'https://www.x.org'
  version '2.3.7'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://www.x.org/archive/individual/lib/libXft-2.3.7.tar.xz'
  source_sha256 '79f0b37c45007381c371a790c2754644ad955166dbf2a48e3625032e9bdd4f71'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2114f2123bd6fc24fc4f5d9b16441f0ce70aab9bf752ceb2aff99a79ce576334',
     armv7l: '2114f2123bd6fc24fc4f5d9b16441f0ce70aab9bf752ceb2aff99a79ce576334',
     x86_64: 'bac8b590570dd2b635e90f0b0b383237bf9df45e7c836bad733ff4023b903a4b'
  })

  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libx11' # R
  depends_on 'libxrender' # R
  depends_on 'util_macros' => :build

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
