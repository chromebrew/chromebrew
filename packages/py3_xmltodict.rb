require 'buildsystems/pip'

class Py3_xmltodict < Pip
  description 'XMLtoDict makes working with XML feel like you are working with JSON.'
  homepage 'https://github.com/martinblech/xmltodict/'
  version "1.0.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5b78119c0ea53d75b5091903f2cbe35cbe4521f64f1f4c0bc26a0b9dbf1be214',
     armv7l: '5b78119c0ea53d75b5091903f2cbe35cbe4521f64f1f4c0bc26a0b9dbf1be214',
       i686: '75219203a7427c1754b25824bacf36c4c692b5f380f989c5d6843aa50d035006',
     x86_64: '8554bad3b750aac6535024d85d6ff2da94c7cb2bb6317672bfe9860b14046988'
  })

  depends_on 'python3' => :build

  no_source_build
end
