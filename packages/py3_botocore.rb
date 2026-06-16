require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.30-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e55e5e42f7763451751d4ddfbf4c0434c072d8c93b03c204e44bc2324d5eed4b',
     armv7l: 'e55e5e42f7763451751d4ddfbf4c0434c072d8c93b03c204e44bc2324d5eed4b',
       i686: 'b64684dd5de911d526ddca81576f9cb9a021e52afccef3640309e9274ab73dae',
     x86_64: '0a3350841782746555e057bfa0a46730cd4eddc4a7cae4f0d06b1189510184bc'
  })

  depends_on 'python3' => :logical

  no_source_build
end
