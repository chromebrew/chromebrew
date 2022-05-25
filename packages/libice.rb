require 'package'

class Libice < Package
  description 'X.org X Inter Client Exchange Library'
  homepage 'http://www.x.org'
  version '1.1.0'
  license 'X11'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libice.git'
  git_hashtag "libICE-#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libice/1.1.0_armv7l/libice-1.1.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libice/1.1.0_armv7l/libice-1.1.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libice/1.1.0_i686/libice-1.1.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libice/1.1.0_x86_64/libice-1.1.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '98119ae9368b7d11644676afac7d66a220bc5329f41b236004e5c3f76e2ce7ec',
     armv7l: '98119ae9368b7d11644676afac7d66a220bc5329f41b236004e5c3f76e2ce7ec',
       i686: 'aa06dc806a8c3b32e8bcd401297d19bddf05689927842001be65cd66b0fc96b2',
     x86_64: '58bbc7896230e0d630360a6b4686b7c41f40f44f1477da31bff7cde929569752'
  })

  depends_on 'libxtrans' => :build
  depends_on 'libx11' => :build
  depends_on 'libbsd' # R
  depends_on 'glibc' # R
  depends_on 'libmd' # R

  patchelf

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
