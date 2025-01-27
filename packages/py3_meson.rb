require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.7.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '51e5a9596669a9f06f2ba793c23e688d3bf5643d66b8553ae95f220b14412c7b',
     armv7l: '51e5a9596669a9f06f2ba793c23e688d3bf5643d66b8553ae95f220b14412c7b',
       i686: '1f06a0f9868f86cc6b248895c56192be5733edd0d0e39e79c87a1ac7849b299d',
     x86_64: 'd71da0c9d1dc0d6352609ec2f393869876f1fc863adc9375f0b7f4321728eaef'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'

  no_source_build
end
