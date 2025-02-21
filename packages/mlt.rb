require 'buildsystems/cmake'

class Mlt < CMake
  description 'MLT is a LGPL multimedia framework designed for video editing.'
  homepage 'https://github.com/mltframework/mlt'
  version '7.30.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/mltframework/mlt.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: '2586e37abb032ed127fd111bc44aa56e93643876bf6b11480176ae6c4a5cb916',
     x86_64: '2844eaa792b4b75061c39b80a332dd592e086d7dbac13fda67bdbe2b5fe99012'
  })

  depends_on 'alsa_lib'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libxml2' # R
end
