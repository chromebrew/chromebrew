require 'buildsystems/pip'

class Py3_brotlicffi < Pip
  description 'Python bindings to the Brotli compression library'
  homepage 'https://github.com/python-hyper/brotlicffi/'
  version "1.2.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fd7ad34b53a600b77d6c4d378666161c9c46ec019a1de240836201c3f7d2c800',
     armv7l: 'fd7ad34b53a600b77d6c4d378666161c9c46ec019a1de240836201c3f7d2c800',
       i686: '2f64467e4a746e15b5e6cfe6bccf04a3986645d1e184a4c6b5acded81f258c86',
     x86_64: '599e01a6b0dcefea0a7270c16a318a0d48fc45fb2c9e7d68131f72949515a960'
  })

  depends_on 'brotli'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'py3_cffi'
  depends_on 'python3' => :logical

  no_source_build
end
