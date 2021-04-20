require 'package'

class Texinfo < Package
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version '6.7-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/texinfo/texinfo-6.7.tar.xz'
  source_sha256 '988403c1542d15ad044600b909997ba3079b10e03224c61188117f3676b02caa'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/texinfo-6.7-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/texinfo-6.7-1-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/texinfo-6.7-1-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/texinfo-6.7-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '005b37aa4e36dea62555ce6ca36426f37ebc66d9f8ecba23cb8c960b3fc7c092',
     armv7l: '005b37aa4e36dea62555ce6ca36426f37ebc66d9f8ecba23cb8c960b3fc7c092',
       i686: '24bf126b3bba3a6dff27bdd869e0c6e3263eb9b04c39003ecc7bc8730230e816',
     x86_64: '4e7a16cb4f7d93a7c949c7ff10b03fa2e27b9db4372e5c138b0f10561fafa292'
  })

  depends_on 'perl_locale_messages'
  depends_on 'perl_text_unidecode'
  depends_on 'perl_unicode_eastasianwidth'

  def self.build
    # configure and make
    system "env #{CREW_ENV_OPTIONS} \
      ./configure #{CREW_OPTIONS} \
      --with-external-Text-Unidecode \
      --with-external-Unicode-EastAsianWidth"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
