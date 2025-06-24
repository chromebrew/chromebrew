require 'buildsystems/pip'

class Py3_retrying < Pip
  description 'Retrying simplifies the task of adding retry behavior to just about anything.'
  homepage 'https://github.com/rholder/retrying/'
  version "1.4.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '71b2618e43b2ce096ad90ea8a0c57dda5e0657b854d1372531230ef9bac975ea',
     armv7l: '71b2618e43b2ce096ad90ea8a0c57dda5e0657b854d1372531230ef9bac975ea',
       i686: '5cd060867dbfc7bc1ae6ad6f7952451f4c523dbb56b5c6ff1dba33024bebf2ef',
     x86_64: '52c23837024cb22e5f380501162134e372bc74ad3958eb4e3ae0635580de683d'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
