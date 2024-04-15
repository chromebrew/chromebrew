require 'package'

class Libxmu < Package
  description 'X.org X interface library for miscellaneous utilities not part of the Xlib standard'
  homepage 'https://www.x.org'
  version '1.1.4'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://www.x.org/archive/individual/lib/libXmu-1.1.4.tar.xz'
  source_sha256 '210de3ab9c3e9382572c25d17c2518a854ce6e2c62c5f8315deac7579e758244'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dc93c77b9fdb855416b04bf6f63f11726ab6e0ca4b5d838b5cc8e7588f73bf9b',
     armv7l: 'dc93c77b9fdb855416b04bf6f63f11726ab6e0ca4b5d838b5cc8e7588f73bf9b',
     x86_64: '7d13dd2d816dc5b42f2db6868eda520ed9b1f9fb8d6cc393fa62959f79d0aec4'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libice' # R
  depends_on 'libmd' # R
  depends_on 'libsm' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R
  depends_on 'libxt' # R
  depends_on 'util_linux' # R
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
