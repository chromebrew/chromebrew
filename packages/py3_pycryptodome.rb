require 'buildsystems/pip'

class Py3_pycryptodome < Pip
  description 'Pycryptodome is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "4.2.0-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ea817902d3640a08304ce0f0dcb68086710f6ab17f982ed396d086c38bd564ac',
     armv7l: 'ea817902d3640a08304ce0f0dcb68086710f6ab17f982ed396d086c38bd564ac',
       i686: '6531f5e393e5861b593dabebc84fd348f66f330833cc546afd4dc6ecc6af32d5',
     x86_64: '541c1732595f229bd52de0610ff4de879160e5e37348fd8991fedab704b57e6f'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
