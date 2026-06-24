require 'buildsystems/pip'

class Py3_setuptools_scm < Pip
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm'
  version "10.1.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd7ef0e373c400e259deccbd34d3cd8801e75f7fd5ae6de0fffb852ccdcb66cdc',
     armv7l: 'd7ef0e373c400e259deccbd34d3cd8801e75f7fd5ae6de0fffb852ccdcb66cdc',
       i686: '1e8142a84029f6be2e25b6eb86cce9989c8be9490162a72179fe4326981cec49',
     x86_64: 'efb1fc965b3bdfc879956590405cf8b37efe95a624ff102e09b40d0435494196'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'
  depends_on 'python3' => :logical

  no_source_build
end
