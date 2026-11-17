require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.1.9-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '909bd43553af818ab9839443fc514a68162692c19e3b6191db4dc28a791ca784',
     armv7l: '909bd43553af818ab9839443fc514a68162692c19e3b6191db4dc28a791ca784',
       i686: '41ec701c1d0bffaa96858b8634d4816e0771f4ca769e7a49e6e7aad5781d3415',
     x86_64: '5e96d3adda090d53c0dee7a170107cb3316e1c257a7254906b08c3116eb1cc81'
  })

  depends_on 'glibc' => :build
  depends_on 'glibc_lib' => :build
  depends_on 'python3' => :logical

  no_source_build
end
