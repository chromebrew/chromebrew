require 'package'

class Gawk < Package
  description 'The gawk utility interprets a special-purpose programming language that makes it possible to handle simple data-reformatting jobs with just a few lines of code.'
  homepage 'https://www.gnu.org/software/gawk/'
  version '5.3.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gawk/gawk-5.3.0.tar.xz'
  source_sha256 'ca9c16d3d11d0ff8c69d79dc0b47267e1329a69b39b799895604ed447d3ca90b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f1b44733f046da402351e65dc672cd21e355d0719b7ac152ad27d7a23302a175',
     armv7l: 'f1b44733f046da402351e65dc672cd21e355d0719b7ac152ad27d7a23302a175',
       i686: 'cfecbdfd324d06675809a7d651659655c2e249134594af1f9dac998e679eb1d6',
     x86_64: 'ce0eb10edf6f35098e654487b3daf8839048179d34098dc90aed4730feb1c086'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libsigsegv' # R
  depends_on 'mpfr' # R
  depends_on 'ncurses' => :build
  depends_on 'readline' # R

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --without-libsigsegv-prefix"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Remove conflict with #{CREW_PREFIX}/bin/awk from mawk package
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/awk"
  end
end
