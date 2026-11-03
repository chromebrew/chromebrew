require 'buildsystems/pip'

class Py3_pycryptodome < Pip
  description 'Pycryptodome is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "4.3.0-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0187b8dbbc6c313b31f3e9c22fcdd3a3d9c6ad3e5b242e80069825ef7ec44e23',
     armv7l: '0187b8dbbc6c313b31f3e9c22fcdd3a3d9c6ad3e5b242e80069825ef7ec44e23',
       i686: 'b07db54180b75e6bd7317800d26b06be9bd12f930e03671a6d30832c02ad34d1',
     x86_64: 'b89a1e2d4478b77b8be59fe4886f10e6f0795f3689f4ea0662a6359acba02039'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
