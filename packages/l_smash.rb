require 'package'

class L_smash < Package
  description 'MP4 muxer and other tools'
  homepage 'https://github.com/l-smash/l-smash'
  @_ver = '2.14.5'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/l-smash/l-smash/archive/v#{@_ver}.tar.gz"
  source_sha256 'e6f7c31de684f4b89ee27e5cd6262bf96f2a5b117ba938d2d606cf6220f05935'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/l_smash-2.14.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/l_smash-2.14.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/l_smash-2.14.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/l_smash-2.14.5-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '5df042cdee6dc70e3670053f5f83a714865227aa4975fb0e655f0c7287a4066e',
     armv7l: '5df042cdee6dc70e3670053f5f83a714865227aa4975fb0e655f0c7287a4066e',
       i686: '822763691f4c3ddeb88d1192154cb53e41afbeb6547b3f1fbd78c666febbe9cc',
     x86_64: 'e6378ac95e629bbc67ee8aa30fa82b0c857e07b5a3e423cb7bee3dcaf31fef30'
  })

  def self.build
    system '[ -x configure ] || ./autogen.sh'
    system "./configure #{CREW_OPTIONS.sub(/--mandir=.*/, '')} \
      --enable-shared \
      --extra-cflags='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      --extra-ldflags='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto'"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
