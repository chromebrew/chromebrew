require 'package'

class Libxxf86dga < Package
  description 'X.org the client library for the XFree86-DGA extension'
  homepage 'https://www.x.org'
  version '1.1.6'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxxf86dga.git'
  git_hashtag "libXxf86dga-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'df5fe89f84bffc941eef3a55b71873c6b9b4597846f776d9d6d07315ddcebecb',
     armv7l: 'df5fe89f84bffc941eef3a55b71873c6b9b4597846f776d9d6d07315ddcebecb',
     x86_64: '6ed7919a1b20aecfcddd03ce63255f36ff82d06fdea1d903af109e377f35ea88'
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
    system "./configure #{CREW_OPTIONS} \
      --sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
