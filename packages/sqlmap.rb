require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.10.8-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e368de6fd28087a56824d00752fe5b0fcbed0faec1cac03aa8e04867dc8709f8',
     armv7l: 'e368de6fd28087a56824d00752fe5b0fcbed0faec1cac03aa8e04867dc8709f8',
       i686: '04c8747afaa1c43ba451096f61dd77fd0b3984c2ab2db0ea3c1cc389cc3af779',
     x86_64: '6d1bf6e1b8fe3586668934dd45abfa30d940dd9e7f35f470fb8275f4a8280b7b'
  })

  depends_on 'python3' => :logical
  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
