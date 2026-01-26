require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.3.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7d0dab8f48933ea972fcc89ebb661536ffe7cf88424077b98de17854b4edb2d0',
     armv7l: '7d0dab8f48933ea972fcc89ebb661536ffe7cf88424077b98de17854b4edb2d0',
       i686: '5950840a7ffcd6cbfaf7df5f43ed9969a601aef9bcae92544ccfd3525a5ff637',
     x86_64: '5ab0e80690eaf3cd1b1938c3215231eff189291e563200e83a723ba843fb4d18'
  })

  depends_on 'python3' => :build

  no_source_build
end
