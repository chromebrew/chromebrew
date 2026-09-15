require 'buildsystems/pip'

class Py3_greenlet < Pip
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  version "3.5.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b452fc9abbc0f0d4e0b894567a068b3ad3c39b1e2293bc07e0e685b9c909b818',
     armv7l: 'b452fc9abbc0f0d4e0b894567a068b3ad3c39b1e2293bc07e0e685b9c909b818',
       i686: 'c1fd0f91af50d3bed512e34fe0c7e6e9fd5738be58250fcd56c777c09ec48bc8',
     x86_64: '7b1c3d70e92025aac077cfb93c8fc36e9fd992bb0e5d0589485ac08e11eb773c'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :logical

  no_source_build
end
