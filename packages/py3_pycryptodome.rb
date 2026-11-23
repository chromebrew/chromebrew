require 'buildsystems/pip'

class Py3_pycryptodome < Pip
  description 'Pycryptodome is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "4.6.0-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5843539e4842737bd4d633af364ed20c6d96a18aaf6a123a716fa984c06278ba',
     armv7l: '5843539e4842737bd4d633af364ed20c6d96a18aaf6a123a716fa984c06278ba',
       i686: 'a96f2a6c5112914f552964e6259bb8090d5c08560c4d555006dcfc3ed15417bf',
     x86_64: 'b48886c6f639d0da66596947392e1af18345f17ab425f917ce6c0684dcb9a8b8'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
