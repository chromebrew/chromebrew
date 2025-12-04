require 'buildsystems/pip'

class Py3_agate_sql < Pip
  description 'Agate-sql adds SQL read/write support to agate.'
  homepage 'https://agate-sql.readthedocs.org/'
  version "0.7.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f7c8a337395025635ee1781f051a9e2b56e5c1bcfeddd944c21a43bf1769ae91',
     armv7l: 'f7c8a337395025635ee1781f051a9e2b56e5c1bcfeddd944c21a43bf1769ae91',
       i686: '07b4f95c993b976bb998b238a0846f4fa8846791592b69e678c40fab7a4dea5a',
     x86_64: 'c6d0ec997624321e0f3094c619f30de54151851bd81e927c26ce03f6d480f0f8'
  })

  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :build

  no_source_build
end
