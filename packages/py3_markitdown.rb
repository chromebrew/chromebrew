require 'buildsystems/pip'

class Py3_markitdown < Pip
  description 'Python tool for converting files and office documents to Markdown.'
  homepage 'https://github.com/microsoft/markitdown'
  version "0.1.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '550ac0ec379f8836105afafd3345c60e18cde6a82a9d327b5d802e1997467c0a',
     armv7l: '550ac0ec379f8836105afafd3345c60e18cde6a82a9d327b5d802e1997467c0a',
       i686: '46476f3908bdd13eb269373c2986d0e83e5d2f460deea795ab1ea5aba06c03fc',
     x86_64: '7c0304ffc1a442bc2e2f5a6523dbd0590ec872798d69e1f1ca6c4b688ef1b694'
  })

  depends_on 'python3' => :logical

  no_source_build
end
