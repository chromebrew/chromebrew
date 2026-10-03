require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.1.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cb79ffb4d03a8c58339bd7262e997ff12c8b5a5d63822155fcadb35966804c8b',
     armv7l: 'cb79ffb4d03a8c58339bd7262e997ff12c8b5a5d63822155fcadb35966804c8b',
       i686: '296c6817741c8c703cd88cd62fc156ebf0f9f5e967d8deed9e863be1f22f35c0',
     x86_64: '6a556849cf4c79cde80b9a377a31e7698db565e4cf1b59aa1b359db15c5e2c07'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :build
  depends_on 'python3' => :logical

  no_source_build
end
