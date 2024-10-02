require 'buildsystems/pip'

class Py3_pycryptodome < Pip
  description 'Pycryptodome is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "3.21.0-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '50f1f2b2fa5c1e9349095a059fff2495a2f824bd8afd37c779722653fc8f2896',
     armv7l: '50f1f2b2fa5c1e9349095a059fff2495a2f824bd8afd37c779722653fc8f2896',
       i686: 'cd3c9870771053cd4c5410c30a8721bfca605ff04406e0aaad88ed06618085a6',
     x86_64: 'ef8d3d861dd967a0c11211c389bc6ff0a9984835096e1d4ec253a92d9f9bc3be'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
