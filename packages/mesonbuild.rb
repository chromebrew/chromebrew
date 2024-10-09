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
    aarch64: '40ca1c717bf517ac259ea1c220986b87a12e67191e624c87a9e9b9d81adb5b4f',
     armv7l: '40ca1c717bf517ac259ea1c220986b87a12e67191e624c87a9e9b9d81adb5b4f',
       i686: 'e110ba453be9694b231dde9c4bfaaac81f33a8e277e62b7c5207b2b8e6082dcb',
     x86_64: '75d8262a75abc0b581b77bac8ef603ae09abe5a2a6563113c1f97c651634166b'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'
end
