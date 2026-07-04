require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.4.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7344ea9d2a26b3f13cdc7b69524d24e9f73528139c8a84acde92291054229d11',
     armv7l: '7344ea9d2a26b3f13cdc7b69524d24e9f73528139c8a84acde92291054229d11',
       i686: '6f1021b6ba45b9f885dc9fa3cfc659721e13bf37e978f8f96b35a72f28880019',
     x86_64: 'de735f4a4666d39045abab1580e5ebaeb34c27b4dca2897c624ff6a73aa2bf8c'
  })

  depends_on 'python3' => :logical

  no_source_build
end
