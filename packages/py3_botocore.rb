require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.80-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8467fb31e5684cfe4c94d6e85c1624205a41dd732f77cb035d4906d5e4f3fd4d',
     armv7l: '8467fb31e5684cfe4c94d6e85c1624205a41dd732f77cb035d4906d5e4f3fd4d',
       i686: '07a6e32ed569d0bd9a6fd6714bfe07ccc24d86cd236ef6b7ab9893f2923eb064',
     x86_64: '9884027c15fd206fbae567a55214863ac46db1cb0cccb0e4b4d5850b9f2839a7'
  })

  depends_on 'python3' => :logical

  no_source_build
end
