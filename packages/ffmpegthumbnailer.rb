require 'buildsystems/cmake'

class Ffmpegthumbnailer < CMake
  description 'FFmpegthumbnailer is a lightweight video thumbnailer that can be used by file managers to create thumbnails for your video files.'
  homepage 'https://github.com/dirkvdb/ffmpegthumbnailer'
  version '2.2.2-1b5a779'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/dirkvdb/ffmpegthumbnailer.git'
  git_hashtag '1b5a77983240bcf00a4ef7702c07bcd8f4e5f97c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fd757ed0f568529db3b8cf0fa804fef50710f00a513ccc5dc85c940d4f400342',
     armv7l: 'fd757ed0f568529db3b8cf0fa804fef50710f00a513ccc5dc85c940d4f400342',
     x86_64: 'e3093743ca3ecdc3b0638aac7c12d94bb7ec450fc07696ec20d155151f370ffb'
  })

  depends_on 'ffmpeg' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'zlib' # R

  cmake_options '-DENABLE_GIO=ON -DENABLE_THUMBNAILER=ON'
end
