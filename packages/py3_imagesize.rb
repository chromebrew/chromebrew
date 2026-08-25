require 'buildsystems/pip'

class Py3_imagesize < Pip
  description 'Imagesize gets image size from png/jpeg/jpeg2000/gif file.'
  homepage 'https://github.com/shibukawa/imagesize_py/'
  version "2.0.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1c3ddb89204dc289b744b0bd66a647a70ff4a8c6046bf6bcb4240eb6631fbb32',
     armv7l: '1c3ddb89204dc289b744b0bd66a647a70ff4a8c6046bf6bcb4240eb6631fbb32',
       i686: '1c3659ddcf11067a0b60bacd134ce8f986f6596de11902c2f38c3628f3d5ca07',
     x86_64: '16d996643b86f969a82db82fe220dea2b4d7c1bd03130a23c52ee055555f504b'
  })

  depends_on 'python3' => :logical

  no_source_build
end
