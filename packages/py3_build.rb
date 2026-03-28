require 'buildsystems/pip'

class Py3_build < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://pypa-build.readthedocs.io/'
  version "1.4.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9950e7ef12c7af31fea422dc6e90a9f2f78d5300335427150d26a24cd73d9c58',
     armv7l: '9950e7ef12c7af31fea422dc6e90a9f2f78d5300335427150d26a24cd73d9c58',
       i686: 'cd85dd3024c0460e98d4271cbd6176cdfb5a78fb82fef8e7b1af1b2b4fb54b3a',
     x86_64: '377fabeb0eb0bb26fc65cd316cd0909c9b8418b331ffe496c26722037fb2f795'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_pyproject_hooks'
  depends_on 'py3_tomli'
  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
