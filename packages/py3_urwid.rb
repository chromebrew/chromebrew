require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "5.1.2-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '81eabeb84118a230491470e8622ec11ab851f43b1c48aed5ecbd24eec1ae32cd',
     armv7l: '81eabeb84118a230491470e8622ec11ab851f43b1c48aed5ecbd24eec1ae32cd',
       i686: 'a6aeb81688e3a11b80883c3353a6821787989558c8d1f3092663031a11f1c3ad',
     x86_64: '2512406c3cb41f4f0eaa6bb4964e635911a6ff3f94948197345575b6a61845ce'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
