require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "2.35.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'df4701047d5218b23e384ab230a3ca251dd01773ac1a9336f8a60f82f9d1143e',
     armv7l: 'df4701047d5218b23e384ab230a3ca251dd01773ac1a9336f8a60f82f9d1143e',
       i686: 'fa841a851338ebeae3eee5e16daeca4ce1130da340f1a2f34cc137477d0966f6',
     x86_64: '38e1d9786d0e9d925ee970566b13f0c7ed602bf2e1a724c632ccf3c2b93ed18a'
  })

  depends_on 'python3' => :logical

  no_source_build
end
