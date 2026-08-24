require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "7.0.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '23b5b9ffac9c6646f03998591496af5d05d04e51d77072adafd37babdb7c4014',
     armv7l: '23b5b9ffac9c6646f03998591496af5d05d04e51d77072adafd37babdb7c4014',
       i686: 'b5ea50d1e7b1090ffbd78fda97dea28813d967c2c885b5727d7bfaea55410c8d',
     x86_64: '3c9526798e2d1adf6e0b05a4c2959988f63521ea4f1e52dd2911bf5a5ca2d0d9'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :logical

  no_source_build
end
