require 'buildsystems/meson'

class Libva < Meson
  description 'Libva is an implementation for VA-API (Video Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  version '2.19.0'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/intel/libva.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.19.0_armv7l/libva-2.19.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.19.0_armv7l/libva-2.19.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libva/2.19.0_x86_64/libva-2.19.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'cbc1a7a27adf19ba377682d00fca0480471bf962b379a7b6df80858e8d61ed34',
     armv7l: 'cbc1a7a27adf19ba377682d00fca0480471bf962b379a7b6df80858e8d61ed34',
     x86_64: 'cf3a431910d59e410c8e24ea1164783b4644f3c807c54d7e7b85c07bcd8f2808'
  })

  depends_on 'glibc' # R
  depends_on 'libdrm' # R
  depends_on 'libglvnd' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'mesa'
  depends_on 'wayland' # R
end
