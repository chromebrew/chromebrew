require 'package'

class Texinfo < Package
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version '6.8'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/texinfo/texinfo-6.8.tar.xz'
  source_sha256 '8eb753ed28bca21f8f56c1a180362aed789229bd62fff58bf8368e9beb59fec4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/6.8_armv7l/texinfo-6.8-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/6.8_armv7l/texinfo-6.8-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/6.8_i686/texinfo-6.8-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/6.8_x86_64/texinfo-6.8-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8ab8c07b8df6060de246818fe5c94d8fb52c1c16789eddc1ecdcf47d77a53e71',
     armv7l: '8ab8c07b8df6060de246818fe5c94d8fb52c1c16789eddc1ecdcf47d77a53e71',
       i686: 'd0a9f83f9314f21775cdddf404dfd63117ad55a22bfc2c2134c22e045ed7e1ac',
     x86_64: '9b3df80fbebafc830f9ad99c73ab8aaaa3ad0d0ca13cf33a6a4ed9fb737e8ed3'
  })

  depends_on 'perl_locale_messages'
  depends_on 'perl_text_unidecode'
  depends_on 'perl_unicode_eastasianwidth'

  def self.build
    # configure and make
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
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
