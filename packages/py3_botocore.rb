require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.5-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5a6879744c0f6b8d282b84635a02d9100ba9596777df414560b21c477416ae06',
     armv7l: '5a6879744c0f6b8d282b84635a02d9100ba9596777df414560b21c477416ae06',
       i686: '69581e96d6b8eaa575c8137c76523fd3b5c3e63cc3bbf76cb40b60156dacfc50',
     x86_64: '4a4640d67cbbf217ab733f9e4888a5ae5c90981a02472357ee3a40a639541c68'
  })

  depends_on 'python3' => :logical

  no_source_build
end
