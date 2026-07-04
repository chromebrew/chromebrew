require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "3.1.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '52bf920251419c154f2d28cd1f3c453b665882af93d06f27ba0f50bfaea0274d',
     armv7l: '52bf920251419c154f2d28cd1f3c453b665882af93d06f27ba0f50bfaea0274d',
       i686: 'd2ebfcf11abd312f8bfe9d6df801184cc479aee216c9d2a7a1d7c645fbeb1208',
     x86_64: 'a559cc57a66fd594ad27acb600b98dbec9315ac52da97935bb594e334fa39385'
  })

  depends_on 'python3' => :logical

  no_source_build
end
