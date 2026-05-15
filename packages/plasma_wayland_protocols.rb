require 'buildsystems/cmake'

class Plasma_wayland_protocols < CMake
  description 'Plasma-specific protocols for Wayland.'
  homepage 'https://invent.kde.org/libraries/plasma-wayland-protocols'
  version '1.21.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/libraries/plasma-wayland-protocols.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5a646fcc8105c80ce625546daf39821082e5ffbb2a2fb5c08ece9d1801c483fa',
     armv7l: '5a646fcc8105c80ce625546daf39821082e5ffbb2a2fb5c08ece9d1801c483fa',
     x86_64: '717e7ecc0fb2e7e4ebeef1d0c80f9a118967ab2326f9026ed77e5c3f692c3559'
  })

  depends_on 'extra_cmake_modules'
  depends_on 'qt5_wayland'
end
