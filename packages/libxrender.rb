require 'package'

class Libxrender < Package
  description 'X Rendering Extension client library.'
  homepage 'https://www.x.org'
  version '0.9.11'
  license 'custom'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxrender.git'
  git_hashtag "libXrender-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxrender/0.9.11_armv7l/libxrender-0.9.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxrender/0.9.11_armv7l/libxrender-0.9.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxrender/0.9.11_i686/libxrender-0.9.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxrender/0.9.11_x86_64/libxrender-0.9.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '95daf081a8f482d01668fec433ce1c9d23ababe98a5aa69c77c8da9c4ad9d96e',
     armv7l: '95daf081a8f482d01668fec433ce1c9d23ababe98a5aa69c77c8da9c4ad9d96e',
       i686: '27e29d29acf1d850c8c3d79a11edf1d52d7a939e03f93a66e97f0e817503ad36',
     x86_64: 'c673fc3b85467f65f556491bea8ef9e00abca6dd3a665959c6046dd3827520f1'
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
