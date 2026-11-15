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
    aarch64: 'ce3be32a98c661182e4470ba8eb618f7521a974cc3437d02d048bdc4fdb84582',
     armv7l: 'ce3be32a98c661182e4470ba8eb618f7521a974cc3437d02d048bdc4fdb84582',
     x86_64: '73aee39beff9d1e20ed78b9369da059e348d00a8330d62b70730d0c5844e862b'
  })

  depends_on 'glibc' # R
end
