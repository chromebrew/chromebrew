require 'buildsystems/pip'

class Py3_pluggy < Pip
  description 'Pluggy provides plugin and hook calling mechanisms for Python.'
  homepage 'https://pluggy.readthedocs.io/'
  version "1.5.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd93467759965605813ee372926e589821e66f0264f2a865f4e238a26f2d5d894',
     armv7l: 'd93467759965605813ee372926e589821e66f0264f2a865f4e238a26f2d5d894',
       i686: '2c171b8d02c6992cfbb1bd896dbd5a68fd930a8906735674b93e9cb715240d20',
     x86_64: 'f4123f23001465132d9620a211cf9b1de687f62b296457537a2b6474416c7325'
  })

  depends_on 'python3' => :build

  no_source_build
end
