require 'buildsystems/autotools'

class Swig < Autotools
  description 'Simplified Wrapper and Interface Generator'
  homepage 'https://www.swig.org/'
  version '4.2.1'
  license 'GPL-3, BSD and BSD-2'
  compatibility 'all'
  source_url 'https://github.com/swig/swig'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4dd380d5e80b9ae4391dbdbec4cbb22013a568a09306c70f6e57a85dfbf6be23',
     armv7l: '4dd380d5e80b9ae4391dbdbec4cbb22013a568a09306c70f6e57a85dfbf6be23',
       i686: 'cfe9668c35011ba63d3e8f707c60a247fe759c77f3d9b3f1d1574f4962400e1f',
     x86_64: '8e5dd6a82bee42492d27ace3073f45cc3436e225ccd8deb33845f0b8b0318fdd'
  })

  depends_on 'boost' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'pcre' => :build
  depends_on 'pcre2' # R
  depends_on 'zlib' # R
end
