require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.100-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b23f0902c1c398c566491aa5d8b3e5ce0d312b693f2695271d967daf1bb87d04',
     armv7l: 'b23f0902c1c398c566491aa5d8b3e5ce0d312b693f2695271d967daf1bb87d04',
       i686: '61d5c508281c7edd4fb914d42fabd473cbcd7ae1c20855cd4cdef8673cbaf4d3',
     x86_64: '306f094b52ad92993d7e71ec09fdac7a6a722728046b116d92495ea709318871'
  })

  depends_on 'python3' => :logical

  no_source_build
end
