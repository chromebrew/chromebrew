require 'buildsystems/meson'

class Libglvnd < Meson
  description 'The GL Vendor-Neutral Dispatch library'
  homepage 'https://gitlab.freedesktop.org/glvnd/libglvnd'
  version '1.7.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/glvnd/libglvnd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '09e9b0c74fc26c5e7efc5829465ce53cb717a9d631236b0e53731be9df9b7617',
     armv7l: '09e9b0c74fc26c5e7efc5829465ce53cb717a9d631236b0e53731be9df9b7617',
     x86_64: '8d0fcb934f6a57903cfc3259e23c5ce0a0d5fcbb0040809fea210a5d812a55f9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glproto' => :build
  depends_on 'libx11' # R
  depends_on 'libxext' => :build
  depends_on 'python3' => :build
end
