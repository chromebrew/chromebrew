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
    aarch64: '2ad333d174a10229b8d5eadf73c82acade4604fa190aa6a181badaefb3bd11e4',
     armv7l: '2ad333d174a10229b8d5eadf73c82acade4604fa190aa6a181badaefb3bd11e4',
       i686: '3dd275bb7679a8e7b28f5128a3416183eb8b6f9ed803ee531dc81a8449f72e36',
     x86_64: '7004189fafe7b555354243db1b733ffa622d802b8f0d78764ec991a1e6f417a0'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'nasm' => :build
end
