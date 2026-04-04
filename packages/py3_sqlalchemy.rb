require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.0.49-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '63035a209de876121e68ad6ece3684aabb65baddb178e072858bfb388f5965dc',
     armv7l: '63035a209de876121e68ad6ece3684aabb65baddb178e072858bfb388f5965dc',
       i686: '71c4de9758f2a945efb846b34bd5deee129d809e1ae622f80b5129d97f1f4d8e',
     x86_64: '4953f1dc6d8daa0fe12004c90e323c1f6eb3e8a25b3e92c4e174eb9c8433756b'
  })

  depends_on 'glibc' => :library
  depends_on 'python3' => :logical

  no_source_build
end
