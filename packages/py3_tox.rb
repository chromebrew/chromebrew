require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.28.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b6530b0833d53823414a9a719e96020a113e5442396a672230a3d8c362055ea3',
     armv7l: 'b6530b0833d53823414a9a719e96020a113e5442396a672230a3d8c362055ea3',
       i686: '97df3c288b77c483d3df7e94d9fdcb96b6a4cd9500af0456499d834bd75f769d',
     x86_64: '855b8c36111547e1b2ca4bf946cdee15cd4fd0148b34354409aa58a47f7e19a7'
  })

  depends_on 'py3_py'
  depends_on 'py3_filelock'
  depends_on 'py3_six'
  depends_on 'py3_packaging'
  depends_on 'py3_virtualenv'
  depends_on 'py3_pluggy'
  depends_on 'py3_toml'
  depends_on 'python3' => :build

  no_source_build
end
