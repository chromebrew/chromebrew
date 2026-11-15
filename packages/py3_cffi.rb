require 'buildsystems/pip'

class Py3_cffi < Pip
  description 'C Foreign Function Interface for Python calling C code.'
  homepage 'https://cffi.readthedocs.io/'
  version "2.1.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/python-cffi/cffi.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd3f7e19b26c4b94af794f8e424ce8fac7443863d0c8d2c282716e405c832c6a2',
     armv7l: 'd3f7e19b26c4b94af794f8e424ce8fac7443863d0c8d2c282716e405c832c6a2',
       i686: 'cda148327f9f6e5f54d5cf14fe58f79814ae0ca7f1c0d54c785e5769a8a60bab',
     x86_64: '156cff2b608eb1bbe94495a3021fd91e8e6b7f814d73fedbf7f48ba41b6871e0'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libffi' => :library
  depends_on 'python3' => :logical

  no_fhs
end
