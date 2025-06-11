require 'buildsystems/meson'

class Lz4 < Meson
  description 'LZ4 is lossless compression algorithm, providing compression speed at 400 MB/s per core (0.16 Bytes/cycle).'
  homepage 'https://lz4.org/'
  version '1.10.0-1'
  license 'BSD-2 and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/lz4/lz4.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9669e8adb89378c650bcbe5d81d25e04bd2ad6703f322d68b05eb7e0fe7d8d0e',
     armv7l: '9669e8adb89378c650bcbe5d81d25e04bd2ad6703f322d68b05eb7e0fe7d8d0e',
       i686: '90a0e67a0f7fb1bdc016fb3ced6691d895d35b9d9d5ab2cac974c63c13cbf262',
     x86_64: '1c82e13055a0150477a4fb27d8ede4a9e373cc1c610587dd23da971989dcfab6'
  })

  depends_on 'glibc' # R

  meson_build_relative_dir 'build/meson'
end
