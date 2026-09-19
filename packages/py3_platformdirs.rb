require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.11.10-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9463c4a0616b9b9041fb1860cb2e4769bf3a5b8cc94188d4e950508ca2515764',
     armv7l: '9463c4a0616b9b9041fb1860cb2e4769bf3a5b8cc94188d4e950508ca2515764',
       i686: '31a59fe0f62c6f9f93007ced8501ab16128603971e33f6a102218f6452324b56',
     x86_64: 'f01308611ce47f86ddb96ea7a674392b2832f7371db88b9fde59428f5e543f46'
  })

  depends_on 'python3' => :logical

  no_source_build
end
