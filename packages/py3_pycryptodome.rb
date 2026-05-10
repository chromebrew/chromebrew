require 'buildsystems/pip'

class Py3_pycryptodome < Pip
  description 'Pycryptodome is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "3.23.0-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd2581b1fb320c7daf3855645a529ecfa43b677fff712ae8006605c57dc91e3e6',
     armv7l: 'd2581b1fb320c7daf3855645a529ecfa43b677fff712ae8006605c57dc91e3e6',
       i686: '30bd77c1217af105908da5fec5ebb403292980620c487aa94e9f1f1885118fda',
     x86_64: 'ac0de0faa88f6ae4c6fbf990ca2377addf227fe1b0d824b6c110322c3b1b4713'
  })

  depends_on 'glibc' => :library
  depends_on 'python3' => :logical

  no_source_build
end
