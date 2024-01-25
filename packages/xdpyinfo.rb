# Adapted from Arch Linux xorg-xdpyinfo PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/xorg-xdpyinfo/trunk/PKGBUILD

require 'package'

class Xdpyinfo < Package
  description 'Display information utility for X'
  homepage 'https://xorg.freedesktop.org/'
  version '1.3.3'
  license 'MIT-with-advertising'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xdpyinfo.git'
  git_hashtag "xdpyinfo-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6041d86f4823e1dd0918d920124ef79eebfa2f7496947d3171a8f58d09358b33',
     armv7l: '6041d86f4823e1dd0918d920124ef79eebfa2f7496947d3171a8f58d09358b33',
       i686: '95f969d2ad43b575c2d7d0eaa87b06200699e4b2923ff35f12e03ccc84797ccd',
     x86_64: '50a3cd0a5276633ef0b5d825a76fb90fa5f10d5790ed9a394eb900924d44d667'
  })

  depends_on 'xorg_proto' => :build
  depends_on 'glibc' # R
  depends_on 'libdmx' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxcomposite' # R
  depends_on 'libxext' # R
  depends_on 'libxi' # R
  depends_on 'libxinerama' # R
  depends_on 'libxrender' # R
  depends_on 'libxtst' # R
  depends_on 'libxxf86dga' # R
  depends_on 'libxxf86vm' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
