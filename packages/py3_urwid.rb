require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.0.9-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3db3a1daf6cb7b99d600254ba852aa97d34ed8c3e510bf7610f228b8d0edef54',
     armv7l: '3db3a1daf6cb7b99d600254ba852aa97d34ed8c3e510bf7610f228b8d0edef54',
       i686: '29c7aa10c9f18555da7b9d355d1ddd878f5596baf796dbeb200cfffb6158cc69',
     x86_64: '7814f95fe375fa069b226326c789b2ab710f68025deb066d276019ecb193025e'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
