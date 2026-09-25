require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cfdd070f3a58e498885700d08e77ac136b9713e419b1798154f1b8508edf071f',
     armv7l: 'cfdd070f3a58e498885700d08e77ac136b9713e419b1798154f1b8508edf071f',
       i686: '5d01ce89bdd93d986c24b1e08d35540619ecb687050b283442aec51d597ea05e',
     x86_64: '91f1e3c7366366534047b787385cbdbf399afdb2724f87f9fddebb08485c1117'
  })

  depends_on 'glibc' => :build
  depends_on 'glibc_lib' => :build
  depends_on 'python3' => :logical

  no_source_build
end
