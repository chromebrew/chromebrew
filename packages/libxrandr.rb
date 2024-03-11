require 'package'

class Libxrandr < Package
  description 'X.org X Resize, Rotate and Reflection extension library'
  homepage 'https://xorg.freedesktop.org/'
  @_ver = '1.5.2'
  version "#{@_ver}-2"
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxrandr.git'
  git_hashtag "libXrandr-#{@_ver}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1fd4c4cbaf1d23c91908689adf29874d2a9de83bece2428c92603fa39cdef70e',
     armv7l: '1fd4c4cbaf1d23c91908689adf29874d2a9de83bece2428c92603fa39cdef70e',
     x86_64: '76c42361b5df7706ade70aa94f21afe89d25dd0710931b39023d4b1493dbd30e'
  })

  depends_on 'libxext'
  depends_on 'libxrender'
  depends_on 'util_macros' => :build
  depends_on 'xorg_proto' => :build
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
