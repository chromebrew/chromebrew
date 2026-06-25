require 'buildsystems/pip'

class Py3_click < Pip
  description 'Click is a simple wrapper around optparse for powerful command line utilities.'
  homepage 'https://click.palletsprojects.com'
  version "8.4.2-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ec310c0c2820b707a8a8a29fa7dd2e2b14eae8a7368526bc6e37a52baeac0364',
     armv7l: 'ec310c0c2820b707a8a8a29fa7dd2e2b14eae8a7368526bc6e37a52baeac0364',
       i686: 'df9b9142c4752372e10c60ceeef3f79c7eb2210629a0c9531d0bfad93225e40c',
     x86_64: '6706cfee714ec99f850755a7fcea502b4eac97821b4678209b1d0d392e7096f3'
  })

  depends_on 'python3' => :logical

  no_source_build
end
