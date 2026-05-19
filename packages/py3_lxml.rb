require 'buildsystems/pip'

class Py3_lxml < Pip
  description 'LXML is a Python library for processing XML and HTML.'
  homepage 'https://lxml.de/'
  version "6.1.1-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a7dbc1e34d86bbe420fb0ea3ce56cd1e7728136de460caff217412021a158e83',
     armv7l: 'a7dbc1e34d86bbe420fb0ea3ce56cd1e7728136de460caff217412021a158e83',
       i686: '5881062315bc97f405daecb68d9f9e0ccc1b2b7c74f4377145185a0521b2133c',
     x86_64: '6ce810d2e1ba76096b2145bacd1a44acf114b85fef1ce7712ebb27c08e6c3f43'
  })

  depends_on 'glibc' => :library
  depends_on 'libxml2' => :library
  depends_on 'libxslt' => :library
  depends_on 'py3_cython' => :build
  depends_on 'python3' => :logical
  depends_on 'zlib' => :library

  no_source_build
end
