require 'buildsystems/pip'

class Py3_meson_python < Pip
  description 'Meson Python build backend (PEP 517)'
  homepage 'https://pypi.org/project/meson-python'
  version "0.16.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f6bc97988fa61aeb2c9b26c0babd4f7d0e194e324b261910f695b64a1639ab24',
     armv7l: 'f6bc97988fa61aeb2c9b26c0babd4f7d0e194e324b261910f695b64a1639ab24',
       i686: 'b86406cfcc02bec98ed679c638ab52096f47da841ea7b755505d5b5f665ac315',
     x86_64: 'c19cff8980b03c2d4c4fc08d9a99550eb6e1d68767a92494c89ea69bc04cba38'
  })

  depends_on 'python3'

  no_source_build
end
