require 'buildsystems/autotools'

class Swig < Autotools
  description 'Simplified Wrapper and Interface Generator'
  homepage 'https://www.swig.org/'
  version '4.5.0'
  license 'GPL-3, BSD and BSD-2'
  compatibility 'all'
  source_url 'https://github.com/swig/swig'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6438b65ba5076638dfdd468dc49dd9b0b8bb2bf9526364ec1928b711c539fd11',
     armv7l: '6438b65ba5076638dfdd468dc49dd9b0b8bb2bf9526364ec1928b711c539fd11',
       i686: '70282d2e2e4e2381e84c3e7f2fc8fe37641eb69988e0aeae6199c6ff27b9ab8f',
     x86_64: 'ed92ef076f7c78f657094f3bc61d4e4a98a614a9e8143caf2b8bbbe0117e3d29'
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
