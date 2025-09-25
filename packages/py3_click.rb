require 'buildsystems/pip'

class Py3_click < Pip
  description 'Click is a simple wrapper around optparse for powerful command line utilities.'
  homepage 'https://click.palletsprojects.com'
  version "8.3.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f81d02c266d69ac6d4634025b87a857f7e23465f5c6c1622fb35cf4ec7b6e5ba',
     armv7l: 'f81d02c266d69ac6d4634025b87a857f7e23465f5c6c1622fb35cf4ec7b6e5ba',
       i686: 'a35e57390009a6f79cd4e7d16b234f2d67cf9f564e966741c99abd45d4664a46',
     x86_64: '9b0ddaf4faafeaf85fcceb317ecd1caafd7df711f3daf3082202cdcedff65dc9'
  })

  depends_on 'python3' => :build

  no_source_build
end
