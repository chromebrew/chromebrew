require 'buildsystems/autotools'

class Libao < Autotools
  description 'Audio output portability library.'
  homepage 'https://gitlab.xiph.org/xiph/libao'
  version '1.2.2'
  license 'GPL-2.0+'
  compatibility 'all'
  source_url 'https://gitlab.xiph.org/xiph/libao.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9af24877fb2b394207801347217d03b1019b5daed7c2e5ac02f924df6f09297b',
     armv7l: '9af24877fb2b394207801347217d03b1019b5daed7c2e5ac02f924df6f09297b',
       i686: '1d4d2d5c95fdb86268265e32d1026395a6591b17e27ca0323702c483c28501ca',
     x86_64: '6948074eddbb8c36e148f29270b7f07474c3f464659f9f8bcabd1336e3295fb0'
  })

  depends_on 'alsa_lib' => :library
  depends_on 'glibc' => :library
end
