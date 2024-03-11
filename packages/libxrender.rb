require 'package'

class Libxrender < Package
  description 'X Rendering Extension client library.'
  homepage 'https://www.x.org'
  version '0.9.11'
  license 'custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxrender.git'
  git_hashtag "libXrender-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '859bf33ee1c94216071d6ef524e3f7ccb977cede86ab483b8936d6ef02ad802f',
     armv7l: '859bf33ee1c94216071d6ef524e3f7ccb977cede86ab483b8936d6ef02ad802f',
     x86_64: '247dda42e157a2eb78da0f9408e0cd8281787df630f6bba62e428d02dd31f217'
  })

  depends_on 'libx11'
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
