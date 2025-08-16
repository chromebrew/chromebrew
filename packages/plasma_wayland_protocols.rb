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
    aarch64: '5ecac893396a61340ca5ee30709101fe7484ef8fe0355ab103ed23a78e081473',
     armv7l: '5ecac893396a61340ca5ee30709101fe7484ef8fe0355ab103ed23a78e081473',
     x86_64: '3e252e1a34cd4685a451cbea7e1e0af24aee16cecb1e3e5bd566a5d0db4ee5f1'
  })

  depends_on 'extra_cmake_modules'
  depends_on 'qt5_wayland'
end
