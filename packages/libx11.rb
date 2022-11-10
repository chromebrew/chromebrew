require 'package'

class Libx11 < Package
  description 'C interface to the X window system'
  homepage 'https://x.org'
  version '1.8.1'
  license 'custom'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libx11.git'
  git_hashtag "libX11-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.8.1_armv7l/libx11-1.8.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.8.1_armv7l/libx11-1.8.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.8.1_i686/libx11-1.8.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.8.1_x86_64/libx11-1.8.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e23c725908bc59c35e3775397b04ffd75c7688b62c1fd306a070e05df635b737',
     armv7l: 'e23c725908bc59c35e3775397b04ffd75c7688b62c1fd306a070e05df635b737',
       i686: 'b5d5653133f3c620c0da79bd8dcd4217501fe32145469591bc7dd2c98d63fb8d',
     x86_64: 'ec9093b929bfdd0ea92e7c87eaa169f528a8da2480d231fe52bf53befc0f8354'
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
    system 'NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
