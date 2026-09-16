require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.95-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0b9b732fe6e7c759fa93c0770ff3143ffc86bb26e07b2f3a4b93f89cd387ac17',
     armv7l: '0b9b732fe6e7c759fa93c0770ff3143ffc86bb26e07b2f3a4b93f89cd387ac17',
       i686: '8d55e7ed315ae4a57a694ca04cc0dd3e460602876545940823b575c7894f95ca',
     x86_64: 'd7ad7eb4c960ab74babcf0685e95cf4084988ae7f24db686669996667fff7b11'
  })

  depends_on 'python3' => :logical

  no_source_build
end
