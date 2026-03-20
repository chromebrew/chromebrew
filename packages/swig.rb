require 'buildsystems/autotools'

class Swig < Autotools
  description 'Simplified Wrapper and Interface Generator'
  homepage 'https://www.swig.org/'
  version '4.4.1'
  license 'GPL-3, BSD and BSD-2'
  compatibility 'all'
  source_url 'https://github.com/swig/swig'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '50e1d502886d1c6d2e995d3c92005a3f7249edbb4dd1d2e59a3e85854db62c68',
     armv7l: '50e1d502886d1c6d2e995d3c92005a3f7249edbb4dd1d2e59a3e85854db62c68',
       i686: 'b42de3edf3f7d194329a6407239ca042386f9d8adfe5b631460cc661dce05836',
     x86_64: 'c5091251c3d1f0793e4bd4b6ef2293bc1f92d2790dd3126b52b80179bb858262'
  })

  depends_on 'boost' => :build
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'pcre' => :build
  depends_on 'pcre2' => :executable
  depends_on 'zlib' => :executable
end
