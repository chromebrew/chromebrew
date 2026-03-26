require 'buildsystems/cmake'

class Pivy < CMake
  description 'python bindings to coin3d'
  homepage 'https://github.com/coin3d/pivy'
  version '0.6.10-26b38e0'
  license 'ISC'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/coin3d/pivy.git'
  git_hashtag '26b38e0766d99b82e9541bb3975a154fbb176264'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ff5abf8dfc63ebb94f229079823308eb10e7c065c9f420f3ecbf2e462ae941c2',
     armv7l: 'ff5abf8dfc63ebb94f229079823308eb10e7c065c9f420f3ecbf2e462ae941c2',
     x86_64: 'b79c2a980bf590e31d30037774888bbd2aee3f65e3506cb62870f87d19870f5b'
  })

  depends_on 'coin' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'swig'
end
