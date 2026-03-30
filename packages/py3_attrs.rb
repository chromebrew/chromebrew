require 'buildsystems/pip'

class Py3_attrs < Pip
  description 'Attrs removes the need to implement object protocols in classes.'
  homepage 'https://www.attrs.org/'
  version "26.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1c67f0d2b938446e2214dd3696d8246e9c3353dad0a5fe33c4bc16cbe45d6b5a',
     armv7l: '1c67f0d2b938446e2214dd3696d8246e9c3353dad0a5fe33c4bc16cbe45d6b5a',
       i686: '43d7ef250aa2cc69448c790b3e2add4e1f1381cc1d8a09bc8cec461f8c3b3362',
     x86_64: '9e304fbf6729fa160fd1561ce24f11a7ca23810a82f3e27a9ba130f764c385ca'
  })

  depends_on 'py3_hatch_vcs' => :build
  depends_on 'py3_hatchling' => :build
  depends_on 'python3' => :logical

  no_source_build
end
