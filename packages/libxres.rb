require 'package'

class Libxres < Package
  description 'X.org X-Resource extension client library'
  homepage 'https://www.x.org/wiki/'
  version '1.2.3'
  license 'X11'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxres.git'
  git_hashtag "libXres-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '463625dc1f61dfc0704c22c26a70ca04b60ab4212c86067b0ae3f9be05396fe3',
     armv7l: '463625dc1f61dfc0704c22c26a70ca04b60ab4212c86067b0ae3f9be05396fe3',
     x86_64: 'a23c48589064b625a4b9f56204595d12ac4f65ea8bd1cbb8b7981090414bf3b0'
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
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
