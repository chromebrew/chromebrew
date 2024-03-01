require 'buildsystems/autotools'

class Flex < Autotools
  description 'Flex (The Fast Lexical Analyzer) is a fast lexical analyser generator tool for generating programs that perform pattern-matching on text.'
  homepage 'https://www.gnu.org/software/flex/'
  version '2.6.4-cf9c659'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/westes/flex.git'
  git_hashtag 'cf9c659c5438961d2dfd9f5326cb2e39b31ab27c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f403031451ec780b44b760139024954245778f5a49379da19611ba830b3bc5c1',
     armv7l: 'f403031451ec780b44b760139024954245778f5a49379da19611ba830b3bc5c1',
       i686: 'e6ffa41d1911e3f7b27855c81ec6f0e44930e8be056492fd9d5c7ebd25b7f4ef',
     x86_64: '0da49f0a50a07ba056dabaf2ef1b0019a55b042815e88e30af3aea91e025289b'
  })

  depends_on 'glibc' # R
  depends_on 'm4' => :build
  depends_on 'bison' => :build

  configure_options '--with-pic --disable-static --enable-shared'
end
