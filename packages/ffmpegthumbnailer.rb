require 'buildsystems/cmake'

class Ffmpegthumbnailer < CMake
  description 'FFmpegthumbnailer is a lightweight video thumbnailer that can be used by file managers to create thumbnails for your video files.'
  homepage 'https://github.com/dirkvdb/ffmpegthumbnailer'
  version '2.4.1'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/dirkvdb/ffmpegthumbnailer.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ceca7f71d1c2b0610ba02ec21882d091566cacecedc456d6e5e28a7468e734bf',
     armv7l: 'ceca7f71d1c2b0610ba02ec21882d091566cacecedc456d6e5e28a7468e734bf',
     x86_64: 'fe4cd3f53b2eebd3a5cd340b5a5b10ea470df602f4fda5572ef8a32a7a116590'
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
