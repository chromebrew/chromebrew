require 'buildsystems/pip'

class Py3_pep517 < Pip
  description 'Python PEP517 is an API to call PEP 517 hooks for building Python packages '
  homepage 'https://pep517.readthedocs.io/'
  version "0.13.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7dc82400e3194a34ac0243f0e2b1bc8a1f8118abb9e3aa1f5e84708e0c2d3554',
     armv7l: '7dc82400e3194a34ac0243f0e2b1bc8a1f8118abb9e3aa1f5e84708e0c2d3554',
       i686: '3cb94c10f900e4f03fc9ba8eeef44e788ec9fb953321127d48a66fb7dfe1825c',
     x86_64: '58576989d4eda6b3bebc576df520ae2b96dd069601a96a43f7360342ac40ab0a'
  })

  depends_on 'python3'
  depends_on 'py3_tomli'

  no_source_build
end
