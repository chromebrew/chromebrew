require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '33f8d9c347e6f48288e2b5b8340fe82bbbb82a47e6c17be6ef39014b7e3ac2f3',
     armv7l: '33f8d9c347e6f48288e2b5b8340fe82bbbb82a47e6c17be6ef39014b7e3ac2f3',
       i686: 'dabecbd5475ede650596e2df71c2d4ceedddf3cab350e888d868b5145a432bd2',
     x86_64: 'a3458f1bf0b21a94c056cca0c671ce7a5a24b805fd22eba8a2de0c28c4e1933e'
  })

  depends_on 'python3' => :logical

  no_source_build
end
