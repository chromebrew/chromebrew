require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.48-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '94ac83d28f436bb7fbeb968a15e6171d54a756132a0e6a7ecaa75190441857df',
     armv7l: '94ac83d28f436bb7fbeb968a15e6171d54a756132a0e6a7ecaa75190441857df',
       i686: 'aa4e2e7426f2d94ba8fd13f1d27cecdf23d7238dc88128f53b3853271931ae8a',
     x86_64: 'd93f64da73299c35f38e0bd86418a2d4180cf849e525363bfb67c8176fceeb39'
  })

  depends_on 'python3' => :logical

  no_source_build
end
