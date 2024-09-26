require 'buildsystems/pip'

class Py3_slugify < Pip
  description 'Python-slugify returns unicode slugs.'
  homepage 'https://github.com/un33k/python-slugify/'
  version "0.0.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '25a308f3a01c35d1aa69f9e750b2f792ca3cd3cbbdaccc92821d7c8938fc8042',
     armv7l: '25a308f3a01c35d1aa69f9e750b2f792ca3cd3cbbdaccc92821d7c8938fc8042',
       i686: '2e08fb31c9f37ac554e6ea659a7af3ed853a51a18006bd29aeab3b137650507b',
     x86_64: '37ccbe3e6b11eabf9d284e8d3ec03e6c970b31eab3e61c8fd37cdd9f11aa3c2f'
  })

  depends_on 'py3_text_unidecode'
  depends_on 'python3' => :build

  no_source_build
end
