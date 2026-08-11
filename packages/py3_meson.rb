require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.12.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd819cdb16536769ff4d7631cd037992fa43f2137662de766015489589083aecd',
     armv7l: 'd819cdb16536769ff4d7631cd037992fa43f2137662de766015489589083aecd',
       i686: '7755fbcfa08e1333beafde5f061fbf655af6af5f6633e398715ecc97a5f48414',
     x86_64: 'fbc3f2fa46a205699bf3d3a8588768cf444c7fe0bd42e2ed750b8db4e93985d3'
  })

  depends_on 'ninja'
  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
