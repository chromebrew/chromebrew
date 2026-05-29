require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.4.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7855ef8095b50346d26f2b413778a661711b26f8cb5afcde8775ebc323a7068d',
     armv7l: '7855ef8095b50346d26f2b413778a661711b26f8cb5afcde8775ebc323a7068d',
       i686: '9eef730f0089530b963022f8bd47eb7e17d692b6473eb33b01d834df678f1e50',
     x86_64: '7cfb681207ab028d9a08f1cd667439cc0d3d9f5262425aa66fea81d97ae39128'
  })

  depends_on 'python3' => :logical

  no_source_build
end
