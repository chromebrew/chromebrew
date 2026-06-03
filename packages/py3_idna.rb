require 'buildsystems/pip'

class Py3_idna < Pip
  description 'IDNA provides internationalized domain names for Python.'
  homepage 'https://github.com/kjd/idna/'
  version "3.18-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e80cbded7f7a525c494d54e3e6e11d3ec87cad21a9eb1d244207b0e15708aefe',
     armv7l: 'e80cbded7f7a525c494d54e3e6e11d3ec87cad21a9eb1d244207b0e15708aefe',
       i686: '617f750d4c092a53401e7250b0c89a97ca56303b77ba113753d90446119ed417',
     x86_64: 'f2099cb8cfa6dca9b35a7862c7c97cbbd1aaf089b0971d58b9fbab321b1c5e15'
  })

  depends_on 'python3' => :logical

  no_source_build
end
