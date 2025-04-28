require 'buildsystems/pip'

class Py3_importlib_metadata < Pip
  description 'Importlib metadata reads metadata from Python packages.'
  homepage 'https://github.com/python/importlib_metadata/'
  version "8.7.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '616d4d25f0a1d3638bbf1628d0d6459ec93a322d70cf01ddb48db1a718ab3801',
     armv7l: '616d4d25f0a1d3638bbf1628d0d6459ec93a322d70cf01ddb48db1a718ab3801',
       i686: '72114da5222f860c5b0a936dee679c223f47e0d5f65a5af1bd0d4eff294adc77',
     x86_64: 'f945eeac56a6d01780e2a535587f79333d4000dd2019e17638e6652d0c954b87'
  })

  depends_on 'py3_zipp'
  depends_on 'python3' => :build

  no_source_build
end
