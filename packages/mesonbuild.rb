require 'buildsystems/python'

class Mesonbuild < Python
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.5.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0ca31011f5e3e89e96381bf81f912da3e8f92d9e1e56eca9572ef65ba62c71d4',
     armv7l: '0ca31011f5e3e89e96381bf81f912da3e8f92d9e1e56eca9572ef65ba62c71d4',
       i686: '30f6aa15f0423935a9b1cab7134617e70b9d28833c7bcbf59687a1d67f13da40',
     x86_64: '713bf3252089d2197b25cb90fc937c80d0422de552388a2c19952913008cebd8'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'
end
