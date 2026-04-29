require 'buildsystems/pip'

class Py3_mako < Pip
  description 'Mako is a super fast templating language.'
  homepage 'https://www.makotemplates.org/'
  version "1.3.12-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1d973d7624af6c18ba5fb0d249d8a7d52093b44154e8942b687337e0e64225ba',
     armv7l: '1d973d7624af6c18ba5fb0d249d8a7d52093b44154e8942b687337e0e64225ba',
       i686: '98f1b0ce88285af8b3d67788994e7e0145b810be0a1df66c6fd6c3c878b41044',
     x86_64: '56a6fd9cf73d1c198a85a9a63938d07c880784b5bdfb215650b150712506b6c9'
  })

  depends_on 'py3_markupsafe'
  depends_on 'python3' => :logical

  no_source_build
end
