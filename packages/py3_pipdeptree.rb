require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "2.30.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'db060b236f31a809945396b6619e31c0f76db2e67094ad2dab857db0f715fa86',
     armv7l: 'db060b236f31a809945396b6619e31c0f76db2e67094ad2dab857db0f715fa86',
       i686: 'cbcabf4aa5fa304932f46d41d824c8830c1c8f980c97cfb614ff7964ec9f5aa3',
     x86_64: 'c9bbf4b8c9a750c9da20f57bd0fa8729ace57e875acf2963b77d8ce6944b99f5'
  })

  depends_on 'python3' => :logical

  no_source_build
end
