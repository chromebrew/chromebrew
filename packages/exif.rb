require 'buildsystems/autotools'

class Exif < Autotools
  description 'A small command-line utility to show EXIF information hidden in JPEG files'
  homepage 'https://libexif.github.io/'
  version '0.6.22'
  license 'LGPL-2+'
  compatibility 'all'
  source_url 'https://github.com/libexif/exif.git'
  git_hashtag "exif-#{version.gsub('.', '_')}-release"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '160f7c51344f87189820a99ef8da0db87a5fce3bc33c796e51d435adce7eeb57',
     armv7l: '160f7c51344f87189820a99ef8da0db87a5fce3bc33c796e51d435adce7eeb57',
       i686: 'd4cf687aa7365857f08c914bab891223366cb2b321876e2fe0665ec9cbeef12e',
     x86_64: '90e05f7b4a54269966f7fd3f954082f10005fa49169c55e2a35de79e61dca650'
  })

  depends_on 'glibc' => :executable
  depends_on 'libexif' => :executable
  depends_on 'popt' => :executable

  run_tests
end
