require 'buildsystems/pip'

class Py3_agate_sql < Pip
  description 'Agate-sql adds SQL read/write support to agate.'
  homepage 'https://agate-sql.readthedocs.org/'
  version "0.7.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4fc5950f45641e243461a92237656ff62bf6d258f383efeb84d8c6246ff18286',
     armv7l: '4fc5950f45641e243461a92237656ff62bf6d258f383efeb84d8c6246ff18286',
       i686: '07b4f95c993b976bb998b238a0846f4fa8846791592b69e678c40fab7a4dea5a',
     x86_64: 'c6d0ec997624321e0f3094c619f30de54151851bd81e927c26ce03f6d480f0f8'
  })

  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :build

  no_source_build
end
