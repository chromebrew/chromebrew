require 'buildsystems/autotools'

class Texinfo < Autotools
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version '7.1-perl5.38'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/texinfo/texinfo-7.1.tar.xz'
  source_sha256 'deeec9f19f159e046fdf8ad22231981806dac332cc372f1c763504ad82b30953'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/7.1-perl5.38_armv7l/texinfo-7.1-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/7.1-perl5.38_armv7l/texinfo-7.1-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/7.1-perl5.38_i686/texinfo-7.1-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/7.1-perl5.38_x86_64/texinfo-7.1-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1993d33be6ade8fc000d23e2b5e0b91bb41da63916e7ceb31698c536bbf3f3f9',
     armv7l: '1993d33be6ade8fc000d23e2b5e0b91bb41da63916e7ceb31698c536bbf3f3f9',
       i686: '63815ca8dbeb9708a7e2bf1c4e611d726b567832c54f1946bbd7d2275b972066',
     x86_64: '45efc72577b1c1a40a91d6a665085dcd6eb9c32a9e023c6d9ca7d5439b0cce96'
  })

  depends_on 'glibc_lib' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'perl' # L
  depends_on 'perl_locale_messages' # L
  depends_on 'perl_text_unidecode' # L
  depends_on 'perl_unicode_eastasianwidth' # L

  configure_options '--with-external-Text-Unidecode \
    --with-external-Unicode-EastAsianWidth'

  run_tests
end
