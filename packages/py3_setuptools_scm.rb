require 'buildsystems/pip'

class Py3_setuptools_scm < Pip
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm'
  version "10.2.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6332e2178978412528ed31b28d1a06961ab55795bb2b2f3b1dddfe76a6d5d6ba',
     armv7l: '6332e2178978412528ed31b28d1a06961ab55795bb2b2f3b1dddfe76a6d5d6ba',
       i686: '10d25cd32d3ba02b1039eee35875ab81cd7b75bcb467d55c6c126114d105abc8',
     x86_64: '16a9d9fa17ba0cf2cdc1b3572fc155fd4164818f60633fc7f51810e6c9d6f752'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'
  depends_on 'python3' => :logical

  no_source_build
end
