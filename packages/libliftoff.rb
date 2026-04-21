require 'buildsystems/meson'

class Libliftoff < Meson
  description 'Lightweight KMS plane library'
  homepage 'https://gitlab.freedesktop.org/emersion/libliftoff'
  version '0.5.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/emersion/libliftoff.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7bc36f9c4c4587ef9bb639fe5d74c977bdb76b0d86d5946ae4870137f2e1ba98',
     armv7l: '7bc36f9c4c4587ef9bb639fe5d74c977bdb76b0d86d5946ae4870137f2e1ba98',
     x86_64: '9f5f2c0af57a132330da1ec28413526e99e84d6518f151b22215202b02e5f623'
  })

  depends_on 'glibc' => :library
  depends_on 'libdrm' => :library
end
