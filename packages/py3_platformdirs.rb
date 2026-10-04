require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.12.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bfc14082961103c1fb278820374d862fd81272a1c6ca5138c8203ebf73ad1002',
     armv7l: 'bfc14082961103c1fb278820374d862fd81272a1c6ca5138c8203ebf73ad1002',
       i686: '823243708550d9eff959fe7dd33daf20192a676b3907bcfbb04f46edaaa6f382',
     x86_64: 'fa1b47854287905312b387c74622cbea13bff19d15671970ab7c6859611ca27a'
  })

  depends_on 'python3' => :logical

  no_source_build
end
