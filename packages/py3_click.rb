require 'buildsystems/pip'

class Py3_click < Pip
  description 'Click is a simple wrapper around optparse for powerful command line utilities.'
  homepage 'https://click.palletsprojects.com'
  version "8.3.1-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1a51345aead4bb1d72967775511b29b09005663e3b2a94a6fc765be389840671',
     armv7l: '1a51345aead4bb1d72967775511b29b09005663e3b2a94a6fc765be389840671',
       i686: '61dee2f326d1a9bcbeaf1ee26e6033571695db644adf3bb29f9d154b9c423572',
     x86_64: '45d3fc3856e1a74e65335a707e8e1f835e17d1a2194daa66f2f79a6d260acf65'
  })

  depends_on 'python3' => :build

  no_source_build
end
