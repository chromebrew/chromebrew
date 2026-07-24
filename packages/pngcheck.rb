require 'buildsystems/cmake'

class Pngcheck < CMake
  description 'pngcheck verifies the integrity of PNG, JNG and MNG files'
  homepage 'http://www.libpng.org/pub/png/apps/pngcheck.html'
  version '4.0.1'
  license 'HPND and GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/pnggroup/pngcheck.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0423cfed0df61dbb619d82cf6df397ee47032bc0a2819bb76663b7e9be8ef8d1',
     armv7l: '0423cfed0df61dbb619d82cf6df397ee47032bc0a2819bb76663b7e9be8ef8d1',
       i686: 'd776bfb26526b9ab3c50c90074d16d8adc1235c57017f23ed38ec7a5c8c63b13',
     x86_64: '9f3790df95f543e5d7959de55710f52b3baeadc05cc62f6c12efc789d0791c7a'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'zlib' => :executable
end
