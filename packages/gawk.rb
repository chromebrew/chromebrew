require 'package'

class Gawk < Package
  description 'The gawk utility interprets a special-purpose programming language that makes it possible to handle simple data-reformatting jobs with just a few lines of code.'
  homepage 'https://www.gnu.org/software/gawk/'
  version '5.2.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gawk/gawk-5.2.2.tar.xz'
  source_sha256 '3c1fce1446b4cbee1cd273bd7ec64bc87d89f61537471cd3e05e33a965a250e9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gawk/5.2.2_armv7l/gawk-5.2.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gawk/5.2.2_armv7l/gawk-5.2.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gawk/5.2.2_i686/gawk-5.2.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gawk/5.2.2_x86_64/gawk-5.2.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bd56940014611f7a6b6689ea57fc8cfa606f8b92c353044de94d897e956aea58',
     armv7l: 'bd56940014611f7a6b6689ea57fc8cfa606f8b92c353044de94d897e956aea58',
       i686: '05c749bdd83b1ef899938f9e3a1dbb6fef3decc8ed4661891ecbd51df11d3f9d',
     x86_64: '06a060445dfbf774bff9e70b205016e3544d99c5da7228989b763a731231cb6d'
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
