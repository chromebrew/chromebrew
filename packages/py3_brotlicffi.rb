require 'buildsystems/pip'

class Py3_brotlicffi < Pip
  description 'Python bindings to the Brotli compression library'
  homepage 'https://github.com/python-hyper/brotlicffi/'
  version "1.2.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3308c059695c241b62e5b6bdd9e216ac6db380af529ddef24e03d1b6ea75f08',
     armv7l: 'a3308c059695c241b62e5b6bdd9e216ac6db380af529ddef24e03d1b6ea75f08',
       i686: 'd6e16115e7bfec1725975bbe3918bcc40b537a16a6e3cc62cced72008fc8fed4',
     x86_64: '226af815b2749ebeb35f9ff29b6f60240632849274d7d5e118f7a1e54ed1b89c'
  })

  depends_on 'brotli'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_cffi'
  depends_on 'python3' # L

  no_source_build
end
