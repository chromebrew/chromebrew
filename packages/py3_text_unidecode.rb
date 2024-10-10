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
    aarch64: '92a89c0812f6cecd3a36763b060cc1377c71f12641571b9e32d5a9e7933de6f0',
     armv7l: '92a89c0812f6cecd3a36763b060cc1377c71f12641571b9e32d5a9e7933de6f0',
       i686: '953559d8d7cab31c1d65cb189c2530461c041225e7295acf0510c4ad9291e75a',
     x86_64: 'c9e77e27e7450f9d33bae1f57191292cd4f8bb393e8485773afa249ada5fef8f'
  })

  depends_on 'python3' => :build

  no_source_build
end
