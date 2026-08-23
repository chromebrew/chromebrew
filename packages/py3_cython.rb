require 'buildsystems/pip'

class Py3_cython < Pip
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  version "3.3.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e3028ebe37c8fc45b93ae82bf5525730c27e5eb9d419c111dd22b12496e6b5bc',
     armv7l: 'e3028ebe37c8fc45b93ae82bf5525730c27e5eb9d419c111dd22b12496e6b5bc',
       i686: '8b9665bec5e6d3cd2925ca9104a08530f476746f0cfb9f4d4827866ed7f58559',
     x86_64: '6afced4ab623157457e57e72cd33ef921ee6e7420fba7490fc5b2f93f3710723'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
