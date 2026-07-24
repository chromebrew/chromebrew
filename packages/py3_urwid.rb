require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.0.6-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '65a23fd7626551953a948b05b6812d93fe26f25a484d3fbfe8ca83e60e7bd814',
     armv7l: '65a23fd7626551953a948b05b6812d93fe26f25a484d3fbfe8ca83e60e7bd814',
       i686: 'b37db6901f4e751ab1be8b8470097aa1deaa0155decea510788e9ad83204d690',
     x86_64: '6770d1354ee6fedcd3db8640f37f8cf898b6a42951e62cfbc2bbb098bee69727'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
