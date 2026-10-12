require 'buildsystems/pip'

class Py3_pycryptodome < Pip
  description 'Pycryptodome is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "3.24.1-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c1449d00ff5aeb63149fb25e3bdea18795217afef9e03c869c26b57947215cc6',
     armv7l: 'c1449d00ff5aeb63149fb25e3bdea18795217afef9e03c869c26b57947215cc6',
       i686: 'c974e84b449ef03d23de158895c65f81b4b801a1298cb31c408ef2cf093aa078',
     x86_64: '963203a10e825832e7ba0a9fb29d4bc6e8c2bc32f5442d645bc5a035f9f5e3f2'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
