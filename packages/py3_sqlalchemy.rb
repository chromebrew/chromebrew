require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.0.50-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '856eb54207a6846b4dd1ac734dc7f52805afdb4ae37f1cc45ae16c1d0c7d3e96',
     armv7l: '856eb54207a6846b4dd1ac734dc7f52805afdb4ae37f1cc45ae16c1d0c7d3e96',
       i686: 'f735ed00e08cc1ecfc39079e06e667ef0916baaa037b26aa3242d94f534f5daf',
     x86_64: '4a77ae385d6e0d52dba57378b2f7e49302426813dc14419cdf6a1541a0a5a31f'
  })

  depends_on 'glibc' => :library
  depends_on 'python3' => :logical

  no_source_build
end
