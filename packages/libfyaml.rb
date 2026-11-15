# Adapted from Arch Linux libfyaml PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libfyaml

require 'buildsystems/cmake'

class Libfyaml < CMake
  description 'Fully feature complete YAML parser and emitter'
  homepage 'https://pantoniou.github.io/libfyaml'
  version '1.0.0-beta2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pantoniou/libfyaml.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4b36a1b46bea50c3006910202a1b0b3f403bc426ac1808151b9582d497048066',
     armv7l: '4b36a1b46bea50c3006910202a1b0b3f403bc426ac1808151b9582d497048066',
       i686: 'af57994f0e29ed444a7956b67ff536c145fbe2b7bf5ce2a479b9f3055846fb27',
     x86_64: 'ab0ba60c21af865dbb0a646afb8cbf1c6a187ae604d783ba54f80fc322c25ba5'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'jq' => :build

  cmake_options '-DBUILD_TESTING=OFF \
                 -DENABLE_LIBCLANG=OFF'
end
