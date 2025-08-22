require 'buildsystems/cmake'

class Plasma_wayland_protocols < CMake
  description 'Plasma-specific protocols for Wayland.'
  homepage 'https://invent.kde.org/libraries/plasma-wayland-protocols'
  version '1.18.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/libraries/plasma-wayland-protocols.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dabb0bc8e3dd140f16e33ddb8edfc641a9924daa0411c4ad9aa1d62d09dd87ec',
     armv7l: 'dabb0bc8e3dd140f16e33ddb8edfc641a9924daa0411c4ad9aa1d62d09dd87ec',
     x86_64: 'd8019f6b3f2c59abe293217685833579f927f799b3155b0551051c4fea32a646'
  })

  depends_on 'extra_cmake_modules'
  depends_on 'qt5_wayland'
end
