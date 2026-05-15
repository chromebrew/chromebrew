require 'buildsystems/cmake'

class Ffmpegthumbnailer < CMake
  description 'FFmpegthumbnailer is a lightweight video thumbnailer that can be used by file managers to create thumbnails for your video files.'
  homepage 'https://github.com/dirkvdb/ffmpegthumbnailer'
  version '2.3.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/dirkvdb/ffmpegthumbnailer.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '30ea82b1f97dc3f1c80582a731d8522d186b29c99caa5eb5216cac873cd7e525',
     armv7l: '30ea82b1f97dc3f1c80582a731d8522d186b29c99caa5eb5216cac873cd7e525',
     x86_64: 'c4ff9cbb3798843b2326fb9d6b2de498899eb41e568e7446d22b01fcf3f8b408'
  })

  depends_on 'ffmpeg' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_fallthrough' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libpng' => :library
  depends_on 'zlib' => :library

  cmake_options '-DENABLE_GIO=ON -DENABLE_THUMBNAILER=ON'
end
