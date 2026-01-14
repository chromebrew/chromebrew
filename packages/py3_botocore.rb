require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.27-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cda64444a09d739f4250887042bbba10edf3208a372f4c189c61d0a0165758fe',
     armv7l: 'cda64444a09d739f4250887042bbba10edf3208a372f4c189c61d0a0165758fe',
       i686: '172de3f99560001052caa361d750ae942e8ae0d32a4cd4949f031d334fab587d',
     x86_64: '6cc6a099f50a2e6880af8fe1366260f53c7ad80794b90a78a7a08d10b873723f'
  })

  depends_on 'python3' => :build

  no_source_build
end
