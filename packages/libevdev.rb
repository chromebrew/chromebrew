require 'buildsystems/meson'

class Libevdev < Meson
  description 'libevdev is a wrapper library for evdev devices.'
  homepage 'https://www.freedesktop.org/wiki/Software/libevdev/'
  version '1.13.5'
  license 'MIT'
  compatibility 'all'
  source_url "https://www.freedesktop.org/software/libevdev/libevdev-#{version}.tar.xz"
  source_sha256 '89918ae7b7c13936e6482604a77a2bfbbb74544c5d039fde01c3fa1bdf639987'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd58b4b84a9f6eee8d9ca8c04bc2a1f6cc08aa1288d60200616d11a1f586706e7',
     armv7l: 'd58b4b84a9f6eee8d9ca8c04bc2a1f6cc08aa1288d60200616d11a1f586706e7',
       i686: 'f697d9e40f91c885f804a4cad23ccc54e8b61e03709bab0977626a3960f6f357',
     x86_64: '54c1c2ed37bdd83ac932ea5ad63267b31b3ed45427479c98a1ca0d43f31d9b01'
  })

  depends_on 'check' => :build
  depends_on 'doxygen' => :build
  depends_on 'glibc' # R
  depends_on 'python3' => :build
end
