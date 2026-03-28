require 'buildsystems/pip'

class Py3_brotlicffi < Pip
  description 'Python bindings to the Brotli compression library'
  homepage 'https://github.com/python-hyper/brotlicffi/'
  version "1.2.0.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '895a32275311c851a067697fa46e9ca713849dcae4e548c4e76569da51fb4cd4',
     armv7l: '895a32275311c851a067697fa46e9ca713849dcae4e548c4e76569da51fb4cd4',
       i686: '294c8bd35ea69abb12c3aa41cb7dfd63b665d3dc700f03a561a647e2eb899b20',
     x86_64: '8cea13963643583f9147407c028d18c28b7ffb1c67ae4231cbf7ed12c5dc1750'
  })

  depends_on 'brotli'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'py3_cffi'
  depends_on 'python3' => :logical

  no_source_build
end
