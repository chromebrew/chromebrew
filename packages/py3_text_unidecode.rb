require 'buildsystems/pip'

class Py3_text_unidecode < Pip
  description 'Text-unicode is the most basic Text::Unidecode port.'
  homepage 'https://github.com/kmike/text-unidecode/'
  version "1.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '246d72090a1770c638ffe4a7291805d6e869bff4d5fdcdf4d602c7b32a4c2644',
     armv7l: '246d72090a1770c638ffe4a7291805d6e869bff4d5fdcdf4d602c7b32a4c2644',
       i686: '360d83586d770f6be85aacb856c48c9c7ca75b3eef1770dde13a3fe4029d68ad',
     x86_64: 'a2fc5c17aeebc8ce4a29a26a5f1962f6160628de5b6d30ede47dd557d69e27d9'
  })

  depends_on 'python3' => :build

  no_source_build
end
