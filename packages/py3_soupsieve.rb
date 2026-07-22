require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  version "2.9.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '59545dfb491fa79bffb95247fdc9dfc9dcf3c73e570d3a1ecf7fdc5f2ebf0cda',
     armv7l: '59545dfb491fa79bffb95247fdc9dfc9dcf3c73e570d3a1ecf7fdc5f2ebf0cda',
       i686: 'fd69ecd44cc30e0b5b102fa63c7e1cc9d2011cc7d583db5662554a96ef57715b',
     x86_64: 'fed9437005236ea6728f9b8b19cffdcdfa8cd57c6f8844512514afe47524bdc3'
  })

  depends_on 'python3' => :logical

  no_source_build
end
