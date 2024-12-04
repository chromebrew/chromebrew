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
    aarch64: '56555446b78f3b62a62fa7f540c9feaf06fa4cab61ae425ec7e4dbb7d57f4af4',
     armv7l: '56555446b78f3b62a62fa7f540c9feaf06fa4cab61ae425ec7e4dbb7d57f4af4',
       i686: '2f0d2eba18269af9bc8ba51fa3268c4d80e12a7cae3a05cb90fd067648c78813',
     x86_64: 'ebbba63584eacd7cc9c50a5fdae18ae83e70f1030835403707187b83872ec5da'
  })

  depends_on 'py3_markupsafe'
  depends_on 'python3' => :build

  no_source_build
end
