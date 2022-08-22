require 'package'

class Mc < Package
  description 'GNU Midnight Commander is a visual file manager'
  homepage 'http://midnight-commander.org/'
  version '4.8.27'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/MidnightCommander/mc.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mc/4.8.27_armv7l/mc-4.8.27-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mc/4.8.27_armv7l/mc-4.8.27-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mc/4.8.27_i686/mc-4.8.27-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mc/4.8.27_x86_64/mc-4.8.27-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9983684570b813813665b0b01925c95e692b49d7e16af51028731db69249d47d',
     armv7l: '9983684570b813813665b0b01925c95e692b49d7e16af51028731db69249d47d',
       i686: '571b209953497deb0a06b762a78e3b071c349f250a9ec5a4b51397638f1c6bb5',
     x86_64: '4194ab8ee4a1add191419107a3e9a7bb6ac0591b08e6a45943cdf55cddb13081'
  })

  depends_on 'glib' => :build
  depends_on 'aspell' => :build
  depends_on 'gpm'

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "env CFLAGS='-pipe -flto=auto' CPPFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
