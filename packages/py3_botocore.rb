require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.82-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5c5dc62b68f13b0da1d08bf63751a096293e703b1d77a77b6e591535e6175681',
     armv7l: '5c5dc62b68f13b0da1d08bf63751a096293e703b1d77a77b6e591535e6175681',
       i686: '45ee7656da3c178e8c41a7119126965feb81c39cfbe6e56804f4d6e27e73720f',
     x86_64: 'fb749f718152246046cc64d2e1be46360cb0cafed9fa3ab8f96cd770d41387e4'
  })

  depends_on 'python3' => :logical

  no_source_build
end
