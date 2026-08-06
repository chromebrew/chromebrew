require 'buildsystems/pip'

class Py3_mako < Pip
  description 'Mako is a super fast templating language.'
  homepage 'https://www.makotemplates.org/'
  version "1.4.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1fbca5e8fa8216bcedcdca6203451c7f31bf0b085ea339a28c828cb9a0403127',
     armv7l: '1fbca5e8fa8216bcedcdca6203451c7f31bf0b085ea339a28c828cb9a0403127',
       i686: '633a06566f6d32e23b00b6b786ca2c58d85aff20bba25229fe8085e39118a11d',
     x86_64: 'd1b814d235b945230d230d7b70b1f6408e864e10d19e758f031963b2f43a4354'
  })

  depends_on 'py3_markupsafe'
  depends_on 'python3' => :logical

  no_source_build
end
