require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.51-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '97f35e3483fe8b91a4bb780bd7b57f13f66b9d856ac466a0df130b8acd4b267e',
     armv7l: '97f35e3483fe8b91a4bb780bd7b57f13f66b9d856ac466a0df130b8acd4b267e',
       i686: 'ca926743bdecdac35b8e861b6c72b40c8cf764262b38768d105c22307c96d123',
     x86_64: '210575f46ab4e3647ee42bc1421379ef27ee24c315f3fb66442b503258f6e516'
  })

  depends_on 'python3' => :logical

  no_source_build
end
