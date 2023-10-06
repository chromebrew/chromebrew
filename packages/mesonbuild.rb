require 'buildsystems/python'

class Mesonbuild < Python
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '1.2.2'
  version "#{@_ver}-py3.12"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesonbuild/1.2.2-py3.12_armv7l/mesonbuild-1.2.2-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesonbuild/1.2.2-py3.12_armv7l/mesonbuild-1.2.2-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesonbuild/1.2.2-py3.12_i686/mesonbuild-1.2.2-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mesonbuild/1.2.2-py3.12_x86_64/mesonbuild-1.2.2-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ff170b1bf0888c24b79460e2fdd81f667a0e98a630bb971c968575ac232d4f4e',
     armv7l: 'ff170b1bf0888c24b79460e2fdd81f667a0e98a630bb971c968575ac232d4f4e',
       i686: '5e2af53f9cb2bf78254b52523e9f9b235fcc82cd3a15930867fd16f7ed18778e',
     x86_64: 'aef166a97b3091b170032510aae9db58da1d6bb44ee28067f1a01759664465e1'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'
end
