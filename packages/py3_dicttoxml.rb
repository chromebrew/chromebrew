require 'buildsystems/pip'

class Py3_dicttoxml < Pip
  description 'DicttoXML converts Python dictionaries into XML strings.'
  homepage 'https://github.com/quandyfactory/dicttoxml/'
  version "1.7.16-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c5a12d68a3c02553c0933737adc0ee1f7cfab72f4712a00e6a412540d5e041a5',
     armv7l: 'c5a12d68a3c02553c0933737adc0ee1f7cfab72f4712a00e6a412540d5e041a5',
       i686: '46d9ded05149045d524f171d68facded96f555a2cc450743c474fa2188864fb8',
     x86_64: 'b15084525403cb0d6381de467be5cf709f1e3a5ce119b90d5bb34203b00fabef'
  })

  depends_on 'python3' => :build

  no_source_build
end
