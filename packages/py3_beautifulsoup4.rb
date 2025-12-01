require 'buildsystems/pip'

class Py3_beautifulsoup4 < Pip
  description 'BeautifulSoup is a screen-scraping library.'
  homepage 'https://www.crummy.com/software/BeautifulSoup/'
  version "4.14.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '15361331d22d7b5a368b24b5186b5737ecf3d062e7dc5c36d6e2fd3710d09186',
     armv7l: '15361331d22d7b5a368b24b5186b5737ecf3d062e7dc5c36d6e2fd3710d09186',
       i686: '57f448adb26da3827a69393837a166fecdf9db3ad858d2b017d75e685bcc3811',
     x86_64: '3672b32209c8df4b4974266db3dfe6dd47cb0ede9ebd46665437b08a2d7ab3f1'
  })

  depends_on 'py3_hatchling' => :build
  depends_on 'py3_soupsieve'
  depends_on 'python3' => :build

  no_source_build
end
