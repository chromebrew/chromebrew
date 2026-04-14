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
    aarch64: '0e877192cd4f51d3a4df46976474d892e2d3844cef013ede4ba58dbe0609498e',
     armv7l: '0e877192cd4f51d3a4df46976474d892e2d3844cef013ede4ba58dbe0609498e',
       i686: '60df638d8fae70d05b881d5ee3bc99e4f7b131f5694b9be8000dd69e36ea86ee',
     x86_64: 'd60e09872021f6ebc7eb620b5622c28c040faca864cda594b523e9a86bdd2082'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'nasm' => :build if %w[x86_64 i686].include?(ARCH)

  meson_build_relative_dir 'libvmaf'
  # vmaf currently fails to build with default configuration in i686: https://github.com/Netflix/vmaf/issues/1481
  meson_options "-Denable_docs=false -Denable_tests=false -Denable_float=true #{'-Denable_asm=false' if ARCH == 'i686'}"
end
