require 'buildsystems/pip'

class Py3_chardet < Pip
  description 'Chardet is a universal encoding detector.'
  homepage 'https://github.com/chardet/chardet/'
  version "7.4.1-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '939c12791e40019708a2a365a487d1e2e1b9338447969e45c92df55e65726944',
     armv7l: '939c12791e40019708a2a365a487d1e2e1b9338447969e45c92df55e65726944',
       i686: 'f5a985d95f1fc93e7d5e77f9405ab896ce31ae3fb949cf3f24f228e20ebc86a6',
     x86_64: 'ab4b86444ccc40421ce2695ab142d12a361bf9d21dd7c7439e07eac5d235082c'
  })

  depends_on 'glibc' => :library
  depends_on 'python3' => :logical

  no_source_build
end
