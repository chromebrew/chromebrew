require 'buildsystems/pip'

class Py3_dnspython < Pip
  description 'DNSPython is a DNS toolkit.'
  homepage 'https://www.dnspython.org/'
  version "2.8.0-#{CREW_PY_VER}"
  license 'ISC'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2b86abc970b33ca715a0b573bc0d827362e3d10f02d06ff1c7aa46f76558052f',
     armv7l: '2b86abc970b33ca715a0b573bc0d827362e3d10f02d06ff1c7aa46f76558052f',
       i686: '811693403f0b21a17f860c7f98cc18dcf577d2392f61167e0e4d5b6199f55f64',
     x86_64: '6460b3c785604b1c32f9c19bd68cc2122ddaf11716cc437d427a6117c99382d4'
  })

  depends_on 'python3' => :build

  no_source_build
end
