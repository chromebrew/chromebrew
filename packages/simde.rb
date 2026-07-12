require 'buildsystems/meson'

class Simde < Meson
  description "Implementations of SIMD instruction sets for systems which don't natively support them."
  homepage 'https://simd-everywhere.github.io/blog/'
  version '0.8.2'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/simd-everywhere/simde.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '608a9263a2d384fe68f2b73ab2155cb1e62b4c3441c5c0cd36693c4106365705',
     armv7l: '608a9263a2d384fe68f2b73ab2155cb1e62b4c3441c5c0cd36693c4106365705',
     x86_64: '524c27c5bdb6b6e4331b9c3872d8ccc66fca210aa7faef074087f802a8880387'
  })

  depends_on 'glibc' # R
end
