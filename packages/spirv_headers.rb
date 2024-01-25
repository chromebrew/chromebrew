# Adapted from Arch Linux spirv-headers PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/spirv-headers/trunk/PKGBUILD

require 'buildsystems/cmake'

class Spirv_headers < CMake
  homepage 'https://github.com/KhronosGroup/SPIRV-Headers'
  description 'SPIR-V Headers'
  version '1.3.261.1'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/KhronosGroup/SPIRV-Headers.git'
  git_hashtag "sdk-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f0ccd14ad257de154c75417ebe3bb9514acfa1a11fbfda061a76e6114fd9951a',
     armv7l: 'f0ccd14ad257de154c75417ebe3bb9514acfa1a11fbfda061a76e6114fd9951a',
     x86_64: '2349dc931a83b87fc7ef41bec8c3450997df3c8d9065871da8d4e753caf98c54'
  })
end
