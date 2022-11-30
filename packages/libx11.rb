require 'package'

class Libx11 < Package
  description 'C interface to the X window system'
  homepage 'https://x.org'
  version '1.8.2'
  license 'X11'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libx11.git'
  git_hashtag "libX11-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.8.2_armv7l/libx11-1.8.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.8.2_armv7l/libx11-1.8.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.8.2_i686/libx11-1.8.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.8.2_x86_64/libx11-1.8.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd2b730b028358c1954c91b395e16df9458bd11470f33d3763f8bc66614ff4586',
     armv7l: 'd2b730b028358c1954c91b395e16df9458bd11470f33d3763f8bc66614ff4586',
       i686: '57d1124f8242759a79a13f9055cd04cc6e048aa8d857d29316f36deb9e2aade2',
     x86_64: '245e743d40b645bc08fc46d01d94eec907acfd4361af4022cfc2105aea747140'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxtrans' => :build
  depends_on 'llvm' => :build
  depends_on 'xorg_proto' => :build

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
