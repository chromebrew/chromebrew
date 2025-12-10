require 'buildsystems/pip'

class Py3_asciidoc < Pip
  description 'AsciiDoc is a presentable text document format for writing articles, UNIX man pages and other small to medium sized documents.'
  homepage 'https://asciidoc.org/'
  version "10.2.1-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '987ae0626963f97c1f7a8e0d65bc4d69a781372ccd8187ec113b5c8d841053c1',
     armv7l: '987ae0626963f97c1f7a8e0d65bc4d69a781372ccd8187ec113b5c8d841053c1',
       i686: '430871255d02c0343baf7d01c66d0f58d7dd433c39f76599abbaebe40f5980f7',
     x86_64: 'e8b789c3c65d1f6ce98964554184aaf1622fb186f67a7f84313eb818ffb3e038'
  })

  depends_on 'python3' # R

  no_source_build
end
