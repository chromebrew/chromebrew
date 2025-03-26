require 'buildsystems/pip'

class Py3_pytz < Pip
  description 'pytz brings the Olson tz database into Python.'
  homepage 'https://pythonhosted.org/pytz/'
  version "2025.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '681b2d966bd26759824acaeecd66bcb74a69805f2fd636c2206be51a14f03b2c',
     armv7l: '681b2d966bd26759824acaeecd66bcb74a69805f2fd636c2206be51a14f03b2c',
       i686: 'ba168aa832bb782bfaa30432cd35f5ae6f0b9f14ac73a0c5b92034754c987a72',
     x86_64: 'ed8e81014f0d5181735ff129e99b8c90439c1be0a409b0fcebbb378e593d028c'
  })

  depends_on 'python3' => :build

  no_source_build
end
