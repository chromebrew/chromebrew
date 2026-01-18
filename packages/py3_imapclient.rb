require 'buildsystems/pip'

class Py3_imapclient < Pip
  description 'IMAPclient is an easy-to-use, complete IMAP client library.'
  homepage 'https://imapclient.readthedocs.io/'
  version "3.1.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '48adb63778c9cbadbf48ed300303e3555a34e91330aa5e8da5a143b9e0a16074',
     armv7l: '48adb63778c9cbadbf48ed300303e3555a34e91330aa5e8da5a143b9e0a16074',
       i686: '4f3d7a76b84d867a2cb918a40020d4fb45754e749be430ba6c81e1ef96ae73d7',
     x86_64: '8b27636d14d6a362494cb1bd22e81bccd1919145c0d2544c80b1320a324bbdfc'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
