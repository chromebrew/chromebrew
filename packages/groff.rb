require 'buildsystems/autotools'

class Groff < Autotools
  description 'Groff (GNU troff) is a typesetting system that reads plain text mixed with formatting commands and produces formatted output.'
  homepage 'https://www.gnu.org/software/groff/'
  version '1.23.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/groff.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '41fbef186131fef1efbdf4f4108fb36520755977704c5977e799628bbf116b8b',
     armv7l: '41fbef186131fef1efbdf4f4108fb36520755977704c5977e799628bbf116b8b',
       i686: 'c1b8062c03a49aee7920013f9bfbdf7a80931666875e494e9ef3193c61abe394',
     x86_64: '3edf2afaf6283fae794a498332fb2a8042b7020e504d2a5cb600de4ac229c825'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'netpbm' => :build
  # depends_on 'libice' # R (Not needed for groff binary)
  # depends_on 'libsm' # R (Not needed for groff binary)
  # depends_on 'libx11' # R (Not needed for groff binary)
  # depends_on 'libxaw' # R (Not needed for groff binary)
  # depends_on 'libxmu' # R (Not needed for groff binary)
  # depends_on 'libxt' # R (Not needed for groff binary)
  depends_on 'uchardet' # R

  configure_options '--without-x'
end
