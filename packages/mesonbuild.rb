require 'buildsystems/python'

class Mesonbuild < Python
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '1.3.0'
  version "#{@_ver}-py3.12"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ec679042d6d6119267a73044d61e85afa2579a0e8b76e7da3244f51b4d1a4315',
     armv7l: 'ec679042d6d6119267a73044d61e85afa2579a0e8b76e7da3244f51b4d1a4315',
       i686: 'da19152817955bcaf082ed34c17789fb6055e28edbde91d3b32e62002d2cc4a2',
     x86_64: 'b2285f76750fb3a1c2d216407d9d898a79c07dbf727a0c343822947f42db3777'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'
end
