require 'buildsystems/pip'

class Py3_click < Pip
  description 'Click is a simple wrapper around optparse for powerful command line utilities.'
  homepage 'https://click.palletsprojects.com'
  version "8.4.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1faa70590ef310b6e2f05174e23998ea5e92adda26ed83b084b19c0b8f4a117c',
     armv7l: '1faa70590ef310b6e2f05174e23998ea5e92adda26ed83b084b19c0b8f4a117c',
       i686: '54a5fe4e2acdbf593f6ab36b9f7f17e90e40eb161a4adac2e87409c9700f8781',
     x86_64: 'fa85d3c70b5fdd49caced9027763ebadcf077beef1c968aa45c0b68572205fb3'
  })

  depends_on 'python3' => :logical

  no_source_build
end
