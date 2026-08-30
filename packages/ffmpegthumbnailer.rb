require 'buildsystems/cmake'

class Ffmpegthumbnailer < CMake
  description 'FFmpegthumbnailer is a lightweight video thumbnailer that can be used by file managers to create thumbnails for your video files.'
  homepage 'https://github.com/dirkvdb/ffmpegthumbnailer'
  version '2.3.1'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/dirkvdb/ffmpegthumbnailer.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '09af732a9cabdf509a7cfa8c8dbb4b965f43571e32db48d5c3cc91a1f97a0662',
     armv7l: '09af732a9cabdf509a7cfa8c8dbb4b965f43571e32db48d5c3cc91a1f97a0662',
     x86_64: '4fd5ebfda74ec2dd10ef414d3de50e42e1cc4532f3f427b624125f27459dcce2'
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
