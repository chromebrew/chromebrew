require 'buildsystems/pip'

class Py3_mako < Pip
  description 'Mako is a super fast templating language.'
  homepage 'https://www.makotemplates.org/'
  version "1.3.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '220ed206ccd2915c267ac076cf4bda40e388f7011195c8cca8b5b9f2e01c8816',
     armv7l: '220ed206ccd2915c267ac076cf4bda40e388f7011195c8cca8b5b9f2e01c8816',
       i686: '2f0d2eba18269af9bc8ba51fa3268c4d80e12a7cae3a05cb90fd067648c78813',
     x86_64: '019cbaa03a44d593ae1643d8ed18af0848274c01a9127c87c74ebd19ddef213b'
  })

  depends_on 'py3_markupsafe'
  depends_on 'python3' => :build

  no_source_build
end
