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
    aarch64: 'e0ffa5505fff956d6068591ec6683c468fc0ad91fcb134fff82951a0d98270d4',
     armv7l: 'e0ffa5505fff956d6068591ec6683c468fc0ad91fcb134fff82951a0d98270d4',
       i686: '61dee2f326d1a9bcbeaf1ee26e6033571695db644adf3bb29f9d154b9c423572',
     x86_64: '5fc2c6bb11634cabef32e5a5aceaea03b5a3318e8cbba00af163019818c8579e'
  })

  depends_on 'python3' => :build

  no_source_build
end
