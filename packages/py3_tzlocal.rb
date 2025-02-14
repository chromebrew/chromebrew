require 'buildsystems/pip'

class Py3_tzlocal < Pip
  description 'Tzlocal provides tzinfo object for the local timezone.'
  homepage 'https://github.com/regebro/tzlocal/'
  version "5.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'acc0885b141b12379df504747c07141c554b1e56a387c83e9b83700fbcdc17d9',
     armv7l: 'acc0885b141b12379df504747c07141c554b1e56a387c83e9b83700fbcdc17d9',
       i686: '4c632a4039741924a7aa009fb1a6162776c5979476760d5cb7810f43e85a1087',
     x86_64: 'caa54498807e6172b43fcb41bba5dabdcc18c139798a553c34a78710402bcd87'
  })

  depends_on 'py3_pytz'
  depends_on 'python3' => :build

  no_source_build
end
