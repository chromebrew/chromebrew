require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/benediktschmitt/py-filelock/'
  version "3.21.2-#{CREW_PY_VER}"
  license 'Unlicense'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8c9b49ed7102dd6593f8e3c31a9ddee5a30c6f0219913bde85980df3dd1da67b',
     armv7l: '8c9b49ed7102dd6593f8e3c31a9ddee5a30c6f0219913bde85980df3dd1da67b',
       i686: 'eeafbcd3d330a86d2e0f678af5a557f51917ab814f300b4dbaa0f57128f906ce',
     x86_64: '466768d08387be8017b24c416d16836b4977c709f294ef2cc0b4620027db7612'
  })

  depends_on 'python3' => :build

  no_source_build
end
