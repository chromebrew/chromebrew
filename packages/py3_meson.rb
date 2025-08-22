require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.8.4-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5738a823c7879c34a587d9a003145931b6da9cd4bcf87758457af644975f71ec',
     armv7l: '5738a823c7879c34a587d9a003145931b6da9cd4bcf87758457af644975f71ec',
       i686: 'b6b8f0bba7a1d7f5352ccbf6261feebb87c8b6dced0121bf09ef050483f2e86b',
     x86_64: '627e395891e73acecb667994a0d5d4ab8360ce136162f0e54c42f8ddfb2890ae'
  })

  depends_on 'ninja'
  depends_on 'python3'

  no_source_build
end
