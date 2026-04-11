require 'buildsystems/meson'

class Vmaf < Meson
  description 'Perceptual video quality assessment algorithm based on multi-method fusion'
  homepage 'https://github.com/Netflix/vmaf'
  version '3.1.0'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/Netflix/vmaf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '27223f17a875ef85c4d64bffe55f2e755b6657a51a64918a080722799fd34261',
     armv7l: '27223f17a875ef85c4d64bffe55f2e755b6657a51a64918a080722799fd34261',
       i686: '9f180b6295edecf76ce72fcd331693f833a8bc55d70dd6aec9c87563863b471e',
     x86_64: '5379016438e0aaa04fc4da41673b583ae7b846adf360f71bbce318a67271984b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'nasm' => :build if %w[x86_64 i686].include?(ARCH)

  meson_build_relative_dir 'libvmaf'
  # vmaf currently fails to build with default configuration in i686: https://github.com/Netflix/vmaf/issues/1481
  meson_options "-Denable_docs=false -Denable_tests=false -Denable_float=true #{'-Denable_asm=false' if ARCH == 'i686'}"
end
