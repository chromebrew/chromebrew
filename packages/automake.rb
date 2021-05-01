require 'package'

class Automake < Package
  description 'Automake is a tool for automatically generating Makefile.in files compliant with the GNU Coding Standards.'
  homepage 'https://www.gnu.org/software/automake/'
  @_ver = '1.16.3'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/automake/automake-#{@_ver}.tar.gz"
  source_sha256 'ce010788b51f64511a1e9bb2a1ec626037c6d0e7ede32c1c103611b9d3cba65f'

  binary_url ({
     aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/automake/1.16.3_armv7l/automake-1.16.3-chromeos-armv7l.tar.xz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/automake/1.16.3_armv7l/automake-1.16.3-chromeos-armv7l.tar.xz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/automake/1.16.3_i686/automake-1.16.3-chromeos-i686.tar.xz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/automake/1.16.3_x86_64/automake-1.16.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '13375c5e84631bab60166d390fe617db372d56c922cead9193524a1417816fae',
      armv7l: '13375c5e84631bab60166d390fe617db372d56c922cead9193524a1417816fae',
        i686: 'a84d08c639ac69479c7dff68052922e7ab08cbec8e79bd1006ff7e50c7d96df2',
      x86_64: 'b25b4c4716d03ab1969c8a0fd1578ca4c80812144cc2e3115a21692e843c81c0',
  })

  depends_on 'autoconf'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
