require 'buildsystems/pip'

class Py3_docx2txt < Pip
  description 'Docx2txt is a pure python based utility to extract text and images from docx files.'
  homepage 'https://github.com/ankushshah89/python-docx2txt/'
  version "0.9-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5e1093d0dc6ef8f7cdb4283d1877b972f951addd6ded997483161d91aaaa321a',
     armv7l: '5e1093d0dc6ef8f7cdb4283d1877b972f951addd6ded997483161d91aaaa321a',
       i686: 'f483ee44ebf2701b8353622e666fb29be2bf00630abed77c8116552da67469a1',
     x86_64: 'b9c6548bbe2f99ab44b6ae684a8dc52c169be87978df38e580ae481e89a2f2b0'
  })

  depends_on 'python3' => :build

  no_source_build
end
