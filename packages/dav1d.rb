require 'buildsystems/meson'

class Dav1d < Meson
  description 'dav1d is a new AV1 cross-platform decoder, open-source, and focused on speed and correctness.'
  homepage 'https://code.videolan.org/videolan/dav1d'
  version '1.5.1'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://code.videolan.org/videolan/dav1d.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '893caf1d3c9e389d2428a79b74a825e67c969debbcc7a56a66398d5cf613f64b',
     armv7l: '893caf1d3c9e389d2428a79b74a825e67c969debbcc7a56a66398d5cf613f64b',
       i686: '3dd275bb7679a8e7b28f5128a3416183eb8b6f9ed803ee531dc81a8449f72e36',
     x86_64: 'd2d993678e20e9954133255107a0dd2ccc40f53029cba8b4ffcf5cbd54fdb448'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'nasm' => :build
end
