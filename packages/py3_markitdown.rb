require 'buildsystems/pip'

class Py3_markitdown < Pip
  description 'Python tool for converting files and office documents to Markdown.'
  homepage 'https://github.com/microsoft/markitdown'
  version "0.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f36dbd90339e236c71f0520c6387b09c9753475da390f638418563a0c1267edc',
     armv7l: 'f36dbd90339e236c71f0520c6387b09c9753475da390f638418563a0c1267edc',
       i686: 'e13d6f22cce5448f37a2699bae92264e1e57723ebebb2444eea2a805fcc987ef',
     x86_64: 'c2965e8227bd85bc98ffebf6ab18ca7875b5a8bc4fab532193d94793b1f3817e'
  })

  depends_on 'python3' => :build

  no_source_build
end
