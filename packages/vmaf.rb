require 'buildsystems/meson'

class Vmaf < Meson
  description 'Perceptual video quality assessment algorithm based on multi-method fusion'
  homepage 'https://github.com/Netflix/vmaf'
  version '3.2.1'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/Netflix/vmaf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b372e8facf637f0289acca28a128b78bcb93cf3310a9a53748984e202beab14f',
     armv7l: 'b372e8facf637f0289acca28a128b78bcb93cf3310a9a53748984e202beab14f',
       i686: 'e839e4dda8747034e5f1b288a12e7cd533d12c8f5026a3179e6fb0f0a56042b2',
     x86_64: 'a4e4c9c8828cbfec7dd09fd1bb8f66dbf4c4a1f298af753d15dd4255de5d0b99'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'nasm' => :build if %w[x86_64 i686].include?(ARCH)

  meson_build_relative_dir 'libvmaf'
  meson_options '-Denable_docs=false -Denable_tests=false -Denable_float=true'
end
