require 'package'

class Psmisc < Package
  description 'PSmisc is a set of some small useful utilities that use the proc filesystem.'
  homepage 'https://gitlab.com/psmisc/psmisc'
  @_ver = '23.3'
  version "#{@_ver}-1"
  license 'GPL-2'
  compatibility 'all'
  source_url "https://gitlab.com/psmisc/psmisc/-/archive/v#{@_ver}/psmisc-v#{@_ver}.tar.bz2"
  source_sha256 'fe530b0a29902f8660481248fc19f6994927282b4fe0cd992121016144b95fa6'

  def self.build
    system './autogen.sh'
    system "env CFLAGS='-pipe -flto=auto -I#{CREW_PREFIX}/include/ncursesw -fno-stack-protector' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto -I#{CREW_PREFIX}/include/ncurses' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
