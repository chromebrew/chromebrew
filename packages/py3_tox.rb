require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.65.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5d781059429f9d2b2057ead4deeb6f3295260e4f9a8aec1d7751b18d6d53abb0',
     armv7l: '5d781059429f9d2b2057ead4deeb6f3295260e4f9a8aec1d7751b18d6d53abb0',
       i686: 'e75dd55d8b969aaf007228d26a79dd34b98d413813b4f4f5db262023bce18aa9',
     x86_64: 'cab5197c092464aac1186c7c8e14cd20eede16713ce081caf768d4f513ab1fc8'
  })

  depends_on 'py3_filelock'
  depends_on 'py3_packaging'
  depends_on 'py3_pluggy'
  depends_on 'py3_py'
  depends_on 'py3_six'
  depends_on 'py3_toml'
  depends_on 'py3_virtualenv'
  depends_on 'python3' => :logical

  no_source_build
end
