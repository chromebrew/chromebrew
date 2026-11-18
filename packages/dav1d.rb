require 'buildsystems/meson'

class Dav1d < Meson
  description 'dav1d is a new AV1 cross-platform decoder, open-source, and focused on speed and correctness.'
  homepage 'https://code.videolan.org/videolan/dav1d'
  version '1.5.5'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://code.videolan.org/videolan/dav1d.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f809296911a35fe0b5e11b6c45989ffc7cd8374f49b0965b601511e0591f9671',
     armv7l: 'f809296911a35fe0b5e11b6c45989ffc7cd8374f49b0965b601511e0591f9671',
       i686: 'c6468ab9e7796f4609dbcb523e85893b2bf444e9fd1178454db99e67cb6d68e2',
     x86_64: '95e23ce5fc3c885d76a0bd9ac55bf162be7e091d42af3c1132a30168d864e282'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'nasm' => :build
end
