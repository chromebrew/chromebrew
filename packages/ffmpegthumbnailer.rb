require 'buildsystems/cmake'

class Ffmpegthumbnailer < CMake
  description 'FFmpegthumbnailer is a lightweight video thumbnailer that can be used by file managers to create thumbnails for your video files.'
  homepage 'https://github.com/dirkvdb/ffmpegthumbnailer'
  version '2.4.2'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/dirkvdb/ffmpegthumbnailer.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fe1cac49b10015f631dd4b6255f703f56cc08fbe0b1baf3cca44928c5be08724',
     armv7l: 'fe1cac49b10015f631dd4b6255f703f56cc08fbe0b1baf3cca44928c5be08724',
     x86_64: 'd08480502ec0e62f6a369f2a86364ad463a4fd1e057df27295c7bd9bf18b12a8'
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
