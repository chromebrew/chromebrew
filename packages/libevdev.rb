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
    aarch64: 'ef21c213c561863ccb9cea8a5b88501fdec31c094af3238bac482b3db7b4b053',
     armv7l: 'ef21c213c561863ccb9cea8a5b88501fdec31c094af3238bac482b3db7b4b053',
       i686: '69e54f648be62110a5a488c39b5bdd9c0957ea4705a25d82d8e6cde86f704458',
     x86_64: '175b179c49706e118bdb1da0dfa4d216271396eecf3bd289f0db6fc11f631a64'
  })

  depends_on 'check' => :build
  depends_on 'doxygen' => :build
  depends_on 'python3' => :build
  depends_on 'glibc' # R
end
