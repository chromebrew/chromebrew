require 'buildsystems/pip'

class Py3_configparser < Pip
  description 'Configparser backports newer configparser modules to earlier python versions.'
  homepage 'https://github.com/jaraco/configparser/'
  version "7.2.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fd3ec797bc6ac479b914551006b3498e395864c7822abcd606d57c351af0de9d',
     armv7l: 'fd3ec797bc6ac479b914551006b3498e395864c7822abcd606d57c351af0de9d',
       i686: 'efa5fb48152416f67183357d65a2af64aaa8c0c8eabf1086b6688dbfb0f4cd26',
     x86_64: '29214157c0a3771b83e2d9192aeb9464f710e11293bdf7972e48e00995ab276e'
  })

  depends_on 'python3' => :build

  no_source_build
end
