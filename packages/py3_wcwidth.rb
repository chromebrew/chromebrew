require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.8.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '35418219818498bf2f7cec1266b1df9101c8ed9daa82505189555383b4fa84f0',
     armv7l: '35418219818498bf2f7cec1266b1df9101c8ed9daa82505189555383b4fa84f0',
       i686: 'fd83d4193f6f407f7fd0e4edd03c0da0b138977f4a536b69be8c90ebdd7c1749',
     x86_64: 'b31df49a5c5e7a0a36fa45ba7799675f06e0d15973895a587c41c9a9ce3f06e3'
  })

  depends_on 'python3' => :logical

  no_source_build
end
