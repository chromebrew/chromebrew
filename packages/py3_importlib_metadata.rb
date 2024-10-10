require 'buildsystems/pip'

class Py3_importlib_metadata < Pip
  description 'Importlib metadata reads metadata from Python packages.'
  homepage 'https://github.com/python/importlib_metadata/'
  version "8.5.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c7ff5a44d2ef03c633f7506fb02ace0dd983fb70c771528017f70a7f38fec64a',
     armv7l: 'c7ff5a44d2ef03c633f7506fb02ace0dd983fb70c771528017f70a7f38fec64a',
       i686: 'c8de9b424de39039d3fafc55406ec65a957dd2626722ffc5116f4e7e6e6c0a2d',
     x86_64: '4fa27c19a51e6ce3bf015f30239373ac6094e68c1926269524a2f93ec3a8d043'
  })

  depends_on 'py3_zipp'
  depends_on 'python3' => :build

  no_source_build
end
