require 'package'

class Zimg < Package
  description 'Scaling, colorspace conversion, and dithering library'
  homepage 'https://github.com/sekrit-twc/zimg'
  version '3.0.1'
  license 'WTFPL-2'
  compatibility 'all'
  source_url "https://github.com/sekrit-twc/zimg/archive/release-#{version}.tar.gz"
  source_sha256 'c50a0922f4adac4efad77427d13520ed89b8366eef0ef2fa379572951afcc73f'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'c94a5d596cdc50049c842d01603a1facb61eab365f359c260c1ea4a3b19635e6',
     armv7l: 'c94a5d596cdc50049c842d01603a1facb61eab365f359c260c1ea4a3b19635e6',
       i686: '3fa552e994ef9e26ed7668c90b5f7b6dcfac935530a4d219bb4f43f37e6ab43e',
     x86_64: 'b9aac8627b714d48e9d46a63a674e173f53ee4f4e74834b3141fcdfe94cf0f84'
  })

  @lto = ARCH == 'i686' || ARCH == 'x86_64' ? '-flto=auto' : ''

  def self.build
    system '[ -x configure ] || ./autogen.sh'
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE #{@lto}' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE #{@lto}' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE  #{@lto}' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
