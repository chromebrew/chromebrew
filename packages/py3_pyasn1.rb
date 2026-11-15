require 'buildsystems/pip'

class Py3_pyasn1 < Pip
  description 'PyASN.1 is a generic ASN.1 library for Python'
  homepage 'https://github.com/etingof/pyasn1/'
  version "0.6.5-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '81c751398334e72bb0dddeb0e7f0c35952a322bd1fd60362c774fbe783e195d9',
     armv7l: '81c751398334e72bb0dddeb0e7f0c35952a322bd1fd60362c774fbe783e195d9',
       i686: '037cfc5fae6d0de66d9e51c5d1cf5db4092669f041a18842bdb97135468de915',
     x86_64: '5ba3d184ed3e6f53c855f2f5eae6aa08a0ecfddb3c73ad2683cbea20b915fd46'
  })

  depends_on 'python3' => :logical

  no_source_build
end
