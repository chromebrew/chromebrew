require 'buildsystems/pip'

class Py3_build < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://pypa-build.readthedocs.io/'
  version "1.5.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fa96d332f0859252cf834bbee258b005dbac722f6f5d965c3c67b8c271cdbf86',
     armv7l: 'fa96d332f0859252cf834bbee258b005dbac722f6f5d965c3c67b8c271cdbf86',
       i686: 'f77861ff9381e31bccdb9f6f07e4906ced328662403aeed08666d520e8d58c03',
     x86_64: '23b62968c9581a53fe128bfe3688ce9799f74e03ea49e14caf1f1b9415416dff'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_pyproject_hooks'
  depends_on 'py3_tomli'
  depends_on 'python3' => :logical

  no_source_build
end
