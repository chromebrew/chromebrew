require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  version "2.8.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'be21e30c2969378cb8e170cb8f07dd6bdbaab669ace0e61ed93987edd44efc42',
     armv7l: 'be21e30c2969378cb8e170cb8f07dd6bdbaab669ace0e61ed93987edd44efc42',
       i686: '634fde1bd1bce6655f57e97c76d8936004dc17a7197b03574a9613ad3b4f20f5',
     x86_64: 'c6e4623a87c9bdd725231c0b564e587b07cb4d546c50779354b44eff644d52ac'
  })

  depends_on 'python3' => :build

  no_source_build
end
