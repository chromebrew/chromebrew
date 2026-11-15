require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2026.10.23-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4c95e37fd312249d1e6b7d060f86e76a017a70bbe851f1a229c7e40f49e11f46',
     armv7l: '4c95e37fd312249d1e6b7d060f86e76a017a70bbe851f1a229c7e40f49e11f46',
       i686: '32bf414c577e535f0f359a46eb19397827839a03cb5c802c59f395223af30cc6',
     x86_64: '965152cf86e83e1e0342fc30a6f9eb3f09f76cb6105b12d54362da577744934c'
  })

  depends_on 'python3' => :logical

  no_source_build
end
