require 'buildsystems/meson'

class Libevdev < Meson
  description 'libevdev is a wrapper library for evdev devices.'
  homepage 'https://www.freedesktop.org/wiki/Software/libevdev/'
  version '1.13.4'
  license 'MIT'
  compatibility 'all'
  source_url "https://www.freedesktop.org/software/libevdev/libevdev-#{version}.tar.xz"
  source_sha256 'f00ab8d42ad8b905296fab67e13b871f1a424839331516642100f82ad88127cd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7cdc504498a4d6da831ebfb36a7b3112d029b96ccaad4166c92a0f556cd9d89e',
     armv7l: '7cdc504498a4d6da831ebfb36a7b3112d029b96ccaad4166c92a0f556cd9d89e',
       i686: '69e54f648be62110a5a488c39b5bdd9c0957ea4705a25d82d8e6cde86f704458',
     x86_64: '3c285862c00dbbdfd19f88cc9a9cdb5c57580844a5db46c4b4155dae9618f08a'
  })

  depends_on 'check' => :build
  depends_on 'doxygen' => :build
  depends_on 'python3' => :build
  depends_on 'glibc' # R
end
