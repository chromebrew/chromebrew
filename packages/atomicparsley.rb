require 'package'

class Atomicparsley < Package
  description 'AtomicParsley is a lightweight command line program for reading, parsing and setting metadata into MPEG-4 files, in particular, iTunes-style metadata.'
  homepage 'https://github.com/wez/atomicparsley'
  version '0.9.6'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://bitbucket.org/wez/atomicparsley/get/0.9.6.tar.gz'
  source_sha256 '8ba4e3e21d7a9239932e2a6f34842194d8f9eba84ce9eb83fb35369f5f3f05ab'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '55d6f7bf30bd0e178dd9d117c08b6b5c6f6965808f2e483256ab100a0823b4ae',
     armv7l: '55d6f7bf30bd0e178dd9d117c08b6b5c6f6965808f2e483256ab100a0823b4ae',
       i686: '26281255b16153c6fa663cd6f7bea0dc56e11e06bbf5e44396677932937c226c',
     x86_64: '9dc15a38e01fd81e25e515ff69ac7a89fb07ff9771ff85e54e4da29adc523ba8'
  })

  depends_on 'autoconf'
  depends_on 'automake'
  depends_on 'zlibpkg'

  def self.build
    system './autogen.sh'
    system './configure'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
