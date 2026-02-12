require 'package'

class Libxxf86dga < Package
  description 'X.org the client library for the XFree86-DGA extension'
  homepage 'https://www.x.org/wiki/'
  version '1.1.7'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxxf86dga.git'
  git_hashtag "libXxf86dga-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1edc8c4e2508d441d7bdd082c28b4331095a932a193f616307edc515a46ccc3d',
     armv7l: '1edc8c4e2508d441d7bdd082c28b4331095a932a193f616307edc515a46ccc3d',
     x86_64: 'e7915a563d5283427409208366b1d873afda1972b1635443a4d9f18e98b07b4b'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_CONFIGURE_OPTIONS} \
      --sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
