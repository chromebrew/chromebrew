require 'buildsystems/autotools'

class Swig < Autotools
  description 'Simplified Wrapper and Interface Generator'
  homepage 'https://www.swig.org/'
  version '4.5.1'
  license 'GPL-3, BSD and BSD-2'
  compatibility 'all'
  source_url 'https://github.com/swig/swig'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1ecd45b4f95205270925f721b2c62654773615053a84ba4c2cb4be347a5ca58d',
     armv7l: '1ecd45b4f95205270925f721b2c62654773615053a84ba4c2cb4be347a5ca58d',
       i686: '690cf98168c413d131a0e32e928efa5310102d07ae6135fe656d09c1aea394e2',
     x86_64: 'a953a5fbad503b5061ddc79ce373ab54ebd2bbc4353a8781b7984fe4cebc4245'
  })

  depends_on 'boost' => :build
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'pcre' => :build
  depends_on 'pcre2' => :executable
  depends_on 'zlib' => :executable

  autotools_skip_autoreconf
end
