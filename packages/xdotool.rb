# Adapted from Arch Linux xdotool PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/xdotool/trunk/PKGBUILD

require 'package'

class Xdotool < Package
  description 'Command-line X11 automation tool'
  homepage 'https://www.semicomplete.com/projects/xdotool/'
  version '4.20260303.1'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/jordansissel/xdotool.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '82de36e4590faf639a102bca1fd4b7faf5af3bb5f0cf5c99c4b707f42d701a64',
     armv7l: '82de36e4590faf639a102bca1fd4b7faf5af3bb5f0cf5c99c4b707f42d701a64',
     x86_64: 'b7816c01d71594b82753d3bcbcb092b8a08de8dfedc9bc5b46dfc9db8489c48d'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libx11' => :library
  depends_on 'libxinerama' => :library
  depends_on 'libxkbcommon' => :library
  depends_on 'libxtst' => :library

  def self.build
    system "PREFIX=#{CREW_PREFIX} INSTALLLIB=#{CREW_LIB_PREFIX} make WITHOUT_RPATH_FIX=1"
  end

  def self.install
    system "LDCONFIG=#{CREW_PREFIX}/sbin/ldconfig DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} INSTALLLIB=#{CREW_LIB_PREFIX} make install"
  end
end
