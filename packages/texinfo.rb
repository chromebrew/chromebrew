require 'package'

class Texinfo < Package
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version '7.0.3-perl5.36'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/texinfo/texinfo-7.0.3.tar.xz'
  source_sha256 '74b420d09d7f528e84f97aa330f0dd69a98a6053e7a4e01767eed115038807bf'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/7.0.3-perl5.36_armv7l/texinfo-7.0.3-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/7.0.3-perl5.36_armv7l/texinfo-7.0.3-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/7.0.3-perl5.36_i686/texinfo-7.0.3-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/7.0.3-perl5.36_x86_64/texinfo-7.0.3-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1e11dfe2022f476c2fd5c20eba7d7b7a294a2887667e10943eacfb6ca5628839',
     armv7l: '1e11dfe2022f476c2fd5c20eba7d7b7a294a2887667e10943eacfb6ca5628839',
       i686: 'ec6a3eb3994b45d78b5017eec9afab338047af03910cdfab855f3ff30d073642',
     x86_64: '30eab94981ad9ccd2cafbeb8f557bf0c2e99f14c964ea5736269dfdec75e6a57'
  })

  depends_on 'glibc_lib' # R
  depends_on 'ncurses' # R
  depends_on 'perl' # L
  depends_on 'perl_locale_messages' # L
  depends_on 'perl_text_unidecode' # L
  depends_on 'perl_unicode_eastasianwidth' # L

  def self.build
    system "mold -run ./configure #{CREW_OPTIONS} \
      --with-external-Text-Unidecode \
      --with-external-Unicode-EastAsianWidth"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
