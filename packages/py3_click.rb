require 'buildsystems/pip'

class Py3_click < Pip
  description 'Click is a simple wrapper around optparse for powerful command line utilities.'
  homepage 'https://click.palletsprojects.com'
  version '8.1.7-py3.12'
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd4c0a5f5e982bcc8a669b2ec11f51377edbae712d144bbf3436525dd383f65f5',
     armv7l: 'd4c0a5f5e982bcc8a669b2ec11f51377edbae712d144bbf3436525dd383f65f5',
       i686: 'ab4dc83fcf323a270262dcf923d4663a64933c1aa78cb3c8f9eb3d30963349ab',
     x86_64: 'cea82a744892b41202d2809c062f9864c130591bf20176bf1161d97471f831c3'
  })

  depends_on 'python3' => :build

  no_source_build
end
