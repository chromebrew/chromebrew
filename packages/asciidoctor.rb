require 'package'

class Asciidoctor < Package
  description 'A fast text processor & publishing toolchain for converting AsciiDoc to HTML5, DocBook & more.'
  homepage 'https://asciidoctor.org/'
  version '2.0.18'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  is_fake

  depends_on 'ruby_asciidoctor'

end
