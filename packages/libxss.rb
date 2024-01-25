require 'package'

class Libxss < Package
  description 'X11 Screen Saver extension library'
  homepage 'https://gitlab.freedesktop.org/xorg/lib/libxscrnsaver'
  version '1.2.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxscrnsaver.git'
  git_hashtag "libXScrnSaver-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2779424e8d1364c22a3d56cd98bf335721ceb0adb6229db84702009d116b7f72',
     armv7l: '2779424e8d1364c22a3d56cd98bf335721ceb0adb6229db84702009d116b7f72',
       i686: '19428de1250a4399d152cb85de245ae326a47414096e36f0f42f747a1751f5a2',
     x86_64: 'ea6648451677b22506a534c62a3a90a7e12ee433cfee8835dcef65894ee12517'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R
  depends_on 'util_macros' => :build

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
