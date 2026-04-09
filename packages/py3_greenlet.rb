require 'buildsystems/pip'

class Py3_greenlet < Pip
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  version "3.4.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6280e8ff4dbdef2ceae2081e20dcd66cb1d347b49eedda1d9409c28a0ac1ecce',
     armv7l: '6280e8ff4dbdef2ceae2081e20dcd66cb1d347b49eedda1d9409c28a0ac1ecce',
       i686: '660ddcc5a31c1bee56214b3b503acb66611f9fc9301406fb684fdbca794f966e',
     x86_64: 'cd2a11f399bca097f2c168a1c70c7faf63c93c8f40e4f1335e5f6066574d63ad'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :logical

  no_source_build
end
