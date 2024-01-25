require 'package'

class Libxp < Package
  description 'x print service extension library'
  homepage 'https://xorg.freedesktop.org'
  version '1.0.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/lib/libXp-1.0.4.tar.xz'
  source_sha256 '1f19e3b8e82a34a8fd9889a7d9af0abe8588cb03fb57c37c569634cf3b9df1a4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '33ccc7a386d8f0486d019b94ee9b64752294680a6bafe6e4ab27888a0ca243ff',
     armv7l: '33ccc7a386d8f0486d019b94ee9b64752294680a6bafe6e4ab27888a0ca243ff',
       i686: 'e521d3715463b7c64987ec5a19bd54e8c7e06668b8333e38f8e052f0f6f103a7',
     x86_64: '5c9937164f3a122b1af881da8eafa563a1220d3d2ac450730bc356952ea1a672'
  })

  depends_on 'xorg_proto'
  depends_on 'libxext'
  depends_on 'printproto'
  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS} \
      --enable-malloc0returnsnull"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
