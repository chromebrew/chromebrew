require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2026.7.22-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '40e7337ee281cb40a64b85da27ac4a0c90af43f64f30e7259a244f5d7a6c49f6',
     armv7l: '40e7337ee281cb40a64b85da27ac4a0c90af43f64f30e7259a244f5d7a6c49f6',
       i686: '12439cc5dad56e6b3825530e6834a9873a9e71505c816dff516572d8182f8ab6',
     x86_64: 'bb7a5281d35a92d11cff45f1c2eb2b880daacc285b2896b4ca8cb2faaab1f682'
  })

  depends_on 'python3' => :logical

  no_source_build
end
