require 'buildsystems/pip'

class Py3_colorama < Pip
  description 'Colorama makes ANSI color sequences work on MS Windows.'
  homepage 'https://github.com/tartley/colorama/'
  version "0.4.6-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3caabc17efc32e5c6317a31b34335ade66ad272ea34b5613000605cdcf83ac2',
     armv7l: 'a3caabc17efc32e5c6317a31b34335ade66ad272ea34b5613000605cdcf83ac2',
       i686: 'ce8e598bb88be242a00b8db7988477fbe25419e06903f7a7a6c954d6a4b4c666',
     x86_64: '06a42a79ee066fcad9f897898147cc9536834e28c55bdb0add240eceb33f3a85'
  })

  depends_on 'python3' => :build

  no_source_build
end
