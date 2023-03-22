require 'package'

class Psmisc < Package
  description 'PSmisc is a set of some small useful utilities that use the proc filesystem.'
  homepage 'https://gitlab.com/psmisc/psmisc'
  @_ver = '23.6'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url "https://gitlab.com/psmisc/psmisc/-/archive/v#{@_ver}/psmisc-v#{@_ver}.tar.bz2"
  source_sha256 '91573ca0a1a50bd491b7c3cbe400126b0dadef9a2e328030d6469bb2448e0794'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/psmisc/23.6_armv7l/psmisc-23.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/psmisc/23.6_armv7l/psmisc-23.6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/psmisc/23.6_i686/psmisc-23.6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/psmisc/23.6_x86_64/psmisc-23.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd84be50b9c1f15bbd6e547e3b5b323e3218c9e02cd348792afce0106108e09de',
     armv7l: 'd84be50b9c1f15bbd6e547e3b5b323e3218c9e02cd348792afce0106108e09de',
       i686: 'f833aae432564a90811d6196b0353ddeca6a3c818532d05fd161731deb3d960d',
     x86_64: '29a2b3ed12ece0f873cf335f6bcf5ace47a10ffe26e7582cde0ab451c07c8532'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R

  def self.build
    system './autogen.sh'
    system "CFLAGS+=' -I#{CREW_PREFIX}/include/ncurses' ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
