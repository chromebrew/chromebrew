require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.9.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'edebbcf65f7cf238d8b9523063e605b091c2990f5abf5b5ccecabad0cf30754c',
     armv7l: 'edebbcf65f7cf238d8b9523063e605b091c2990f5abf5b5ccecabad0cf30754c',
       i686: 'a0009064ecbaa5cdcbd2b8fc3a2b4c6ff5df2683cba1fe0575c00aa99b495cf0',
     x86_64: 'ceb26093f8f2aa4fbee6b9f64639896b71ae28848be170878e21ad2b01bf8331'
  })

  depends_on 'glibc' => :build
  depends_on 'glibc_lib' => :build
  depends_on 'python3' => :logical

  no_source_build
end
