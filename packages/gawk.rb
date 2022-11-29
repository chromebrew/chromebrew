require 'package'

class Gawk < Package
  description 'The gawk utility interprets a special-purpose programming language that makes it possible to handle simple data-reformatting jobs with just a few lines of code.'
  homepage 'https://www.gnu.org/software/gawk/'
  @_ver = '5.2.1'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gawk/gawk-5.2.1.tar.xz'
  source_sha256 '673553b91f9e18cc5792ed51075df8d510c9040f550a6f74e09c9add243a7e4f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gawk/5.2.1_armv7l/gawk-5.2.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gawk/5.2.1_armv7l/gawk-5.2.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gawk/5.2.1_i686/gawk-5.2.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gawk/5.2.1_x86_64/gawk-5.2.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '863fcd2f1e6a601803aba0c43045ccaef706c3d1ceae301cee0f998daf300d8a',
     armv7l: '863fcd2f1e6a601803aba0c43045ccaef706c3d1ceae301cee0f998daf300d8a',
       i686: 'd8630d6aec58188e3eb1e333b0a3dc7193e083a4389b1f3ab0f7cc5e6ec060fb',
     x86_64: '411fe8d629fbd4b95a419ec41a03dbab52a753f28333b394d8aa89691c85cae9'
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
