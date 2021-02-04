require 'package'

class Psmisc < Package
  description 'PSmisc is a set of some small useful utilities that use the proc filesystem.'
  homepage 'https://gitlab.com/psmisc/psmisc'
  @_ver = '23.3'
  version @_ver
  compatibility 'all'
  source_url "https://gitlab.com/psmisc/psmisc/-/archive/v#{@_ver}/psmisc-v#{@_ver}.tar.bz2"
  source_sha256 'fe530b0a29902f8660481248fc19f6994927282b4fe0cd992121016144b95fa6'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/psmisc-23.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/psmisc-23.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/psmisc-23.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/psmisc-23.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd951db8224299af61b2ca8fb78d64f93667f52df0901928927d8c743216a629f',
     armv7l: 'd951db8224299af61b2ca8fb78d64f93667f52df0901928927d8c743216a629f',
       i686: '00181538fdcdb8922a07ff68f046a1d5333866f76bb241ae628d369179a931c2',
     x86_64: '61880a1987c8295f18c44c8472a953179510318082ed92ac1ade306dbda96bd1'
  })

  def self.build
    system './autogen.sh'
    system './configure --help'
    system "env CFLAGS='-pipe -flto=auto -I#{CREW_PREFIX}/include/ncurses -fno-stack-protector' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto -I#{CREW_PREFIX}/include/ncurses' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
