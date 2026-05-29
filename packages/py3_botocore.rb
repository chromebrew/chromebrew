require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.17-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '21471d3735c237cd8be5eea962d19785d73b80780bbd348b63b8198e1b33f63f',
     armv7l: '21471d3735c237cd8be5eea962d19785d73b80780bbd348b63b8198e1b33f63f',
       i686: '2cb00d5f17c0fe5ae6b7df7f5412f02fec33760b94b5cc04fb2f4d350ad56636',
     x86_64: '84ddc4b51955cc08e46089c201f65e120de16e17bb7991785736c5b689d1b011'
  })

  depends_on 'python3' => :logical

  no_source_build
end
