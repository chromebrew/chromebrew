require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.10.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '90d44925af0aca700150eca07435f7a0654a13556b8bf156c6ee7c15ee969f4d',
     armv7l: '90d44925af0aca700150eca07435f7a0654a13556b8bf156c6ee7c15ee969f4d',
       i686: 'e5049d4547f0f3fc2c604d7a14a14eb25048d0c8ec11acf4ff5e84f9633b0e5a',
     x86_64: '512ab9f020c0bff388ff998cfeea1298803405bb0015cadc2b5eef64d07e12ef'
  })

  depends_on 'ninja'
  depends_on 'python3'

  no_source_build
end
