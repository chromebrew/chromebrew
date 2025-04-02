require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.9.4-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7230d0a903e66203b2c7e882b0f334a519b5c190c2eebc907ccc5b040af1410b',
     armv7l: '7230d0a903e66203b2c7e882b0f334a519b5c190c2eebc907ccc5b040af1410b',
       i686: 'e8530de0063b9bf3cdfcd0aad88de7e9a13f103ca020e4b07cde6cac49f2036a',
     x86_64: 'f69a5ec5993ede83bfafa138f11ccbc7c394ca3660bc155001aa27c7373169b4'
  })

  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
