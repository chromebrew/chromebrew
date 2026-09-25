require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.64.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4284e934770f9692b32a3f98abe2ccc87f3036a8d15f687bbcbb19b85d9b46c9',
     armv7l: '4284e934770f9692b32a3f98abe2ccc87f3036a8d15f687bbcbb19b85d9b46c9',
       i686: 'daa81cdf0e47b0ff44ce725a4216581441eeadd8b0b11ac331ef31bb11a3ac1d',
     x86_64: '0c5c5c30b62ac43018fa037891e7e246b48c778e5a5bbaa970b4ddb5b598d18b'
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
