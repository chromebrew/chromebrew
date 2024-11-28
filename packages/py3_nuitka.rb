require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.5.4-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '76c8bd560bb6a11adb6ca9e7222fd6f838d66339bacbd44631469dccbc27e107',
     armv7l: '76c8bd560bb6a11adb6ca9e7222fd6f838d66339bacbd44631469dccbc27e107',
       i686: 'f6d4434d2334eecf6c7869f47d078dc83718cec882643b4f6fbac6ffa89e00bd',
     x86_64: '37e7870822843659659d416e9dc6578a5d23d40f2ffd5abde25ae6d04cc791af'
  })

  depends_on 'python3' => :build

  no_source_build
end
