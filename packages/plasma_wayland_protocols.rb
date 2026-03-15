require 'buildsystems/cmake'

class Plasma_wayland_protocols < CMake
  description 'Plasma-specific protocols for Wayland.'
  homepage 'https://invent.kde.org/libraries/plasma-wayland-protocols'
  version '1.20.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/libraries/plasma-wayland-protocols.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ba2b6439700166eb98eeb0a8b4df7ba4ca9854d60420064e11911c3e30e29399',
     armv7l: 'ba2b6439700166eb98eeb0a8b4df7ba4ca9854d60420064e11911c3e30e29399',
     x86_64: '1b599b93777dffa4e3b938c4c55893e3ac55afb456c31c48c5543fe5395a3a26'
  })

  depends_on 'extra_cmake_modules'
  depends_on 'qt5_wayland'
end
