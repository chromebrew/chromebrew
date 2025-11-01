require 'buildsystems/meson'

class Dav1d < Meson
  description 'dav1d is a new AV1 cross-platform decoder, open-source, and focused on speed and correctness.'
  homepage 'https://code.videolan.org/videolan/dav1d'
  version '1.5.2'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://code.videolan.org/videolan/dav1d.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e5fc00913117a06424326c6803e9d8ebcca07db9164f734c9b383b4f0d8e456d',
     armv7l: 'e5fc00913117a06424326c6803e9d8ebcca07db9164f734c9b383b4f0d8e456d',
       i686: '4c402d4771a7ebef6b38a8d55d737ae87ca2906acc807b0127ec21c7662e63b9',
     x86_64: '691d00f59ff04c670f19c800e62d02a3a52c5bff947c43535c54ba8f8068877f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'nasm' => :build
end
