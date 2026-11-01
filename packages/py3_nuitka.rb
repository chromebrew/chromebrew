require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "4.3.3-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b75beddd088e4ae61c616794fcde033eba37324b6029f757b22e06d493c668c2',
     armv7l: 'b75beddd088e4ae61c616794fcde033eba37324b6029f757b22e06d493c668c2',
       i686: 'be860f40e7d3c65bbdceefdbaccb725a3509b779038758ed2610fd3eed305035',
     x86_64: 'de98968718eccfa8373f035c31f1870637b6939367f19ed8bac4cddad7cb10ab'
  })

  depends_on 'python3' => :logical

  no_source_build
end
