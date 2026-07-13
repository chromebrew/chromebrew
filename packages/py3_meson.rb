require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.11.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '35ae74775c9d7b6a62948359bf6f95e80fdcd5260ea425ee006c293cc696af38',
     armv7l: '35ae74775c9d7b6a62948359bf6f95e80fdcd5260ea425ee006c293cc696af38',
       i686: 'af8d6a63f9e9baed5a3a189b51c93aedd27f161b80909d737d43ab0260089178',
     x86_64: 'ff39f71513299af6c4d9b4aac79a7cc793c890e12d4f9d29bcc2b884300fe333'
  })

  depends_on 'ninja'
  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
