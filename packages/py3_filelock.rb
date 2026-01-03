require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/benediktschmitt/py-filelock/'
  version "3.20.2-#{CREW_PY_VER}"
  license 'Unlicense'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a4fff1d781a423927760701c64d3df69d484996f232c5c79173bac6f5d6bbce5',
     armv7l: 'a4fff1d781a423927760701c64d3df69d484996f232c5c79173bac6f5d6bbce5',
       i686: '879691479537c0e59a424b2223cdae8a5943199b92580d41222d384b2c702b8e',
     x86_64: '825e11a288c9c5b08fbc0ab993ca169124a5e41af4f99f520ad52dc3fd4cf037'
  })

  depends_on 'python3' => :build

  no_source_build
end
