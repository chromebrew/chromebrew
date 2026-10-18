require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.14.10-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dd9c7b8eceacdfa904bf794e28ac195193ab8329349dd781602343eb064b71dd',
     armv7l: 'dd9c7b8eceacdfa904bf794e28ac195193ab8329349dd781602343eb064b71dd',
       i686: '630072e43fc707fc40f2ddee94c670bb689b5275b58e58f9f193bfaf29de4dbe',
     x86_64: '2e6c728cbbbbc3ac0e545d1f3a05feccc714111592e01b42baed34ddc8cf6da6'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
