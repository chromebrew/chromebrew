require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.9.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '832c212806d09e5006685e719e296b0c4e23d6fc9a84ec7fd33e4a802012aa01',
     armv7l: '832c212806d09e5006685e719e296b0c4e23d6fc9a84ec7fd33e4a802012aa01',
       i686: 'caa4b1ac963f8338c5807a19bceb8d3870d085a111ead1f2af2f4fa9eea2116e',
     x86_64: '79b2abfa8bc547cea522da1bf4c262288aa984a457839821dbe5894bfc98d30b'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :build
  depends_on 'python3' => :logical

  no_source_build
end
