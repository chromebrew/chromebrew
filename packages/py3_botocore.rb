require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.44.3-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd56ed2ed607ed745c692ae18837cf80bfb31a7eb9196c268f80fb5cd14c2c435',
     armv7l: 'd56ed2ed607ed745c692ae18837cf80bfb31a7eb9196c268f80fb5cd14c2c435',
       i686: '292b8c1f11e6fd22922d105f77e61acf646b018351e162a5f3283c90b7dc4521',
     x86_64: 'e6324258d6e4c4cb044b8be8ab3e2512d92da59809407426d044ca4a48ac0c9f'
  })

  depends_on 'python3' => :logical

  no_source_build
end
