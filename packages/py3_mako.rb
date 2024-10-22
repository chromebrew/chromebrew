require 'buildsystems/pip'

class Py3_mako < Pip
  description 'Mako is a super fast templating language.'
  homepage 'https://www.makotemplates.org/'
  version "1.3.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8e7c8fdc66e9913fc8b326077f3ba3de74d7ff339d21bfa4bbceb2bd33c0b3c0',
     armv7l: '8e7c8fdc66e9913fc8b326077f3ba3de74d7ff339d21bfa4bbceb2bd33c0b3c0',
       i686: '065eeeb93a1b4817c9bcb54569158da4c141c843793782617c1fa5fd22dbb731',
     x86_64: 'ec739bb8ffaf2a87b3ebe5539390498278c05a5d9ad5d1b3a8671b0b4ba33078'
  })

  depends_on 'py3_markupsafe'
  depends_on 'python3' => :build

  no_source_build
end
