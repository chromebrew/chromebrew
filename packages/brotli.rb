require 'buildsystems/cmake'

class Brotli < CMake
  description 'Brotli compression format'
  homepage 'https://github.com/google/brotli'
  version '1.2.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/google/brotli.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd0889e7016532dd4a56b7ccfcac1df8e8e8def36eff65c9ff3a901d530075c3c',
     armv7l: 'd0889e7016532dd4a56b7ccfcac1df8e8e8def36eff65c9ff3a901d530075c3c',
       i686: '4106aa361fc1f3e5493bddefdb3df88b554d7783a6589ad872025fbce78472b9',
     x86_64: '0183cd16f1c20c73bbbad805801e4470bdf734759f5c376efa21cfa9b2e761f9'
  })

  depends_on 'glibc' # R
end
