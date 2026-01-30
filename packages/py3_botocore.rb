require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.38-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5bd9dca48eb5a89c499ec82833f851b421a561678110a37fa39288bb985b1fe5',
     armv7l: '5bd9dca48eb5a89c499ec82833f851b421a561678110a37fa39288bb985b1fe5',
       i686: 'c66e9f9b27e2ded0117431cc6fcc25165be2c77abea1d34a17154d670cb56fee',
     x86_64: '5fc737dd2afbd29a8937b18186db530502220154a0d189c4cdc86cc3fbed46e5'
  })

  depends_on 'python3' => :build

  no_source_build
end
