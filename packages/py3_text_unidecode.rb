require 'buildsystems/python'

class Py3_text_unidecode < Python
  description 'Text-unicode is the most basic Text::Unidecode port.'
  homepage 'https://github.com/kmike/text-unidecode/'
  version '1.3-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/kmike/text-unidecode.git'
  version '1.3-py3.12'
  binary_compression 'tar.zst'

  depends_on 'python3' => :build
end
