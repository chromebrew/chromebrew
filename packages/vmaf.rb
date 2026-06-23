require 'buildsystems/meson'

class Vmaf < Meson
  description 'Perceptual video quality assessment algorithm based on multi-method fusion'
  homepage 'https://github.com/Netflix/vmaf'
  version '3.2.0'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/Netflix/vmaf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '21dddd8dd3896d60a4ec84d4d98e45d10cf4ec8a0e973cb6c08931aadff98c43',
     armv7l: '21dddd8dd3896d60a4ec84d4d98e45d10cf4ec8a0e973cb6c08931aadff98c43',
       i686: '1bcda98b43d4622cfae2b41e10841657952760d34368ac3f673b7dc463e52053',
     x86_64: '0f2fe9d3a5959bc8e3608f8b76e823ef67af0302217fb992b70ca5646627d785'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'nasm' => :build if %w[x86_64 i686].include?(ARCH)

  meson_build_relative_dir 'libvmaf'
  # vmaf currently fails to build with default configuration in i686: https://github.com/Netflix/vmaf/issues/1481
  meson_options "-Denable_docs=false -Denable_tests=false -Denable_float=true #{'-Denable_asm=false' if ARCH == 'i686'}"
end
