require 'buildsystems/pip'

class Py3_pycryptodomex < Pip
  description 'Pycryptodomex is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "3.24.0-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1bb09e675d2d11112505f1cc1a6d564cbd9ccb8b1b737f6352080af022f3a9e8',
     armv7l: '1bb09e675d2d11112505f1cc1a6d564cbd9ccb8b1b737f6352080af022f3a9e8',
       i686: '0efc222bd68398187a77c89089ad1d147b184b8d95e0d665409bb479c4b2b209',
     x86_64: '260ef25df7209de8b5bcf72cbb905cc8f1be03d73111e5165ef7a4bc2616014d'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
