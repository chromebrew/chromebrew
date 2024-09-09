require 'buildsystems/pip'

class Py3_brotlicffi < Pip
  description 'Python bindings to the Brotli compression library'
  homepage 'https://github.com/python-hyper/brotlicffi/'
  version '1.1.0.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '667d70ffa552d7534b1d70748f6df74af3489651e00dc41a46291e22991e4467',
     armv7l: '667d70ffa552d7534b1d70748f6df74af3489651e00dc41a46291e22991e4467',
       i686: 'a92b909cfc5e5b4ca937fc523352a13c54b48ad6ddd802daa3af1ef68f3f1ad7',
     x86_64: 'cc1347c14dad469c338953716cae2072e55889fcddfe641800621575bd343b90'
  })

  depends_on 'brotli'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_cffi'
  depends_on 'python3' # L

  no_source_build
end
