require 'buildsystems/pip'

class Py3_scons < Pip
  description 'SCons is an Open Source software construction tool that is, a next-generation build tool.'
  homepage 'https://scons.org/'
  license 'MIT'
  version '4.11.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3e792d05c7fdf24b67fc622c28b45d391b2eb6ba5d36cbd62b9f2fbcbd7bcace',
     armv7l: '3e792d05c7fdf24b67fc622c28b45d391b2eb6ba5d36cbd62b9f2fbcbd7bcace',
       i686: '9402b03312f9eaf3ef2a2a537190fefa56d76d4a48ba5973f73b97d0883510af',
     x86_64: '6856d48cd3ad35d575df526b4643b53ecc824d664d93a58da687c32be66b2a12'
  })

  depends_on 'python3' => :logical
  no_source_build
end
