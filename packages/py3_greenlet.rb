require 'buildsystems/pip'

class Py3_greenlet < Pip
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  version "3.5.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd57e3ab1e21ae9ca701574750ac61435b36ba3714340f3f1f1dae8004b5e1906',
     armv7l: 'd57e3ab1e21ae9ca701574750ac61435b36ba3714340f3f1f1dae8004b5e1906',
       i686: '71b2370ca5337a9b26c71d309944fd59a014fe45b31fe27cbe15cccf87dc7316',
     x86_64: '7317133fc7c2376b59941ff55a4b58acf43eea74958d8c5d4cd30e1381c58e0c'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :logical

  no_source_build
end
