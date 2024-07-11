require 'buildsystems/python'

class Mesonbuild < Python
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version '1.5.0-py3.12'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '65d1a59275ea46c8346c199e1a297c07f4edf7b273e80cb35f43f1769f1dfd37',
     armv7l: '65d1a59275ea46c8346c199e1a297c07f4edf7b273e80cb35f43f1769f1dfd37',
       i686: '3d4d691e0d7cb85d3dce1dcef87e1a6aec08922105645ea24d913b9ca1d12be9',
     x86_64: 'b343055cbda8e13b9336193326de2f93e2478ca3a7883ba9e50f0bd542b25b03'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'
end
