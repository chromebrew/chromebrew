require 'buildsystems/pip'

class Py3_mako < Pip
  description 'Mako is a super fast templating language.'
  homepage 'https://www.makotemplates.org/'
  version "1.4.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6ddc10798d1a8c94d165b5ebaefa0dc7c1338bdb97e6e518bb2c1af35c1d88f6',
     armv7l: '6ddc10798d1a8c94d165b5ebaefa0dc7c1338bdb97e6e518bb2c1af35c1d88f6',
       i686: 'b651d94cf69c550a2de68765c7a5e9e650dc8e73d37a75f3cacbe8da88fed594',
     x86_64: 'c8aafb460b12ac77f5787341d780ff806cfa8c656b74434e28718285d18d3482'
  })

  depends_on 'py3_markupsafe'
  depends_on 'python3' => :logical

  no_source_build
end
