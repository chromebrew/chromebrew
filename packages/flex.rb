require 'package'

class Flex < Package
  description 'Flex (The Fast Lexical Analyzer) is a fast lexical analyser generator tool for generating programs that perform pattern-matching on text.'
  homepage 'https://www.gnu.org/software/flex/'
  version '2.6.4'
  license 'FLEX'
  compatibility 'all'
  source_url 'https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz'
  source_sha256 'e87aae032bf07c26f85ac0ed3250998c37621d95f8bd748b31f15b33c45ee995'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flex/2.6.4_armv7l/flex-2.6.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flex/2.6.4_armv7l/flex-2.6.4-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flex/2.6.4_i686/flex-2.6.4-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flex/2.6.4_x86_64/flex-2.6.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'bbd90f1a0355f5b938713ce21e0b490ae9519f5d4cb272afb025b84884f443b9',
     armv7l: 'bbd90f1a0355f5b938713ce21e0b490ae9519f5d4cb272afb025b84884f443b9',
       i686: '246f92f5cb79802d51596504a7cc8f72367264018409833d389eac07084afd24',
     x86_64: '805be1fdbf4d9d2ce81a652a064c6972eaf91824bb866867eb57c407dd9c2313'
  })

  depends_on 'glibc' # R
  depends_on 'm4'
  depends_on 'bison' => :build

  def self.build
    system './configure', "--libdir=#{CREW_LIB_PREFIX}", '--with-pic', '--disable-static', '--enable-shared'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
