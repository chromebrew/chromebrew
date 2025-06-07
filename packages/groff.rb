require 'buildsystems/autotools'

class Groff < Autotools
  description 'Groff (GNU troff) is a typesetting system that reads plain text mixed with formatting commands and produces formatted output.'
  homepage 'https://www.gnu.org/software/groff/'
  version '1.23.0-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/groff.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c4051837c19bf45308d5f1afd113a14d03efe7479c115e6702e798efc671bb2',
     armv7l: '6c4051837c19bf45308d5f1afd113a14d03efe7479c115e6702e798efc671bb2',
       i686: '9d2cb7c9038714c158345a7f7979379c25ed9b78f13e517989887904c70557ee',
     x86_64: 'c64d5b6b3ff5d80d021d81a35e1b7900e991551bf7b38660ccf3ad47f8b6984c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'netpbm' => :build
  depends_on 'uchardet' # R

  autotools_configure_options '--without-x'
end
