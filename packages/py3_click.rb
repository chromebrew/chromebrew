require 'buildsystems/pip'

class Py3_click < Pip
  description 'Click is a simple wrapper around optparse for powerful command line utilities.'
  homepage 'https://click.palletsprojects.com'
  version "8.2.1-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7c197def47ec55e474fb352170f9082f30f396734b1542f84aa077680c27a744',
     armv7l: '7c197def47ec55e474fb352170f9082f30f396734b1542f84aa077680c27a744',
       i686: '4db0fb3a855f2e3f75eec682902660a56456f6209a73b80221520d6708bc3c7a',
     x86_64: 'a733c6663ee23c93719847a31858a064db438d1244ec65d059f593426e488083'
  })

  depends_on 'python3' => :build

  no_source_build
end
