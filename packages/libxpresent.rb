require 'package'

class Libxpresent < Package
  description 'XPresent extension C library'
  homepage 'https://cgit.freedesktop.org/xorg/lib/libXpresent/'
  version '1.0.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/lib/libXpresent-1.0.1.tar.xz'
  source_sha256 'b964df9e5a066daa5e08d2dc82692c57ca27d00b8cc257e8e960c9f1cf26231b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cdda664576c7628d3bdae2d374ba46492c9cd9f5aadfcefa0c84592439c59cbc',
     armv7l: 'cdda664576c7628d3bdae2d374ba46492c9cd9f5aadfcefa0c84592439c59cbc',
       i686: '6c1983ef7376e615e2ceda7983f8f97c973653375d16ab484168066f3529f7dc',
     x86_64: '71ae88c52f3316a543ec7c6a77958151c77f0aea4020a976468a60be305670a9'
  })

  depends_on 'libxfixes'
  depends_on 'libxrandr'
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R
  depends_on 'libxrender' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
