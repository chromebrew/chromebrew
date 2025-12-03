require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "3.0.4-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '24efe9eec9d2ea22ed9e8dfdee0a2fef187f36f40b83d5bb7d7170c761d48ff2',
     armv7l: '24efe9eec9d2ea22ed9e8dfdee0a2fef187f36f40b83d5bb7d7170c761d48ff2',
       i686: 'ca31e4a8657dcf35b3a563c3e8c5a71b75c30d16ac37c7b54345d587a5a61a06',
     x86_64: 'd7bb7963730ee69645822f888004e0cc2a26ff250686dea0abc0bf82f67084f5'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
