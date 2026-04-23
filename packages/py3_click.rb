require 'buildsystems/pip'

class Py3_click < Pip
  description 'Click is a simple wrapper around optparse for powerful command line utilities.'
  homepage 'https://click.palletsprojects.com'
  version "8.3.3-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ba4df5904e664784516220970c4f5947f3d075afbb133e1f1952d71ef653a030',
     armv7l: 'ba4df5904e664784516220970c4f5947f3d075afbb133e1f1952d71ef653a030',
       i686: 'b076e4dcccc57f33dd33549d61d00f2848ac2bbcd9f7c4892091f362b02f3fc8',
     x86_64: 'a9fa3713f37fafd312892d4e59472efd663b375d0098c6328dbda98e3c1a92cc'
  })

  depends_on 'python3' => :logical

  no_source_build
end
