require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.10.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cfdf65d18b3972d1e187bd6859f133fb908399b12fba4657180cc607325cd971',
     armv7l: 'cfdf65d18b3972d1e187bd6859f133fb908399b12fba4657180cc607325cd971',
       i686: '17cbc3639b1f9cb2be9ae9cc33ca5dd7f4bc197a39cf8638209529974775810f',
     x86_64: 'adec0c681ea607207bf844fce01d37cf136a08d9d5b032bbaa3cea51786cf93d'
  })

  depends_on 'ninja'
  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
