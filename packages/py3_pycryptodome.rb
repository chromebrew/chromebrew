require 'buildsystems/pip'

class Py3_pycryptodome < Pip
  description 'Pycryptodome is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "4.1.0-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e7e7adadc88841fec7b055b9db106403690bec5418b15ac9dd53cf1b11aef899',
     armv7l: 'e7e7adadc88841fec7b055b9db106403690bec5418b15ac9dd53cf1b11aef899',
       i686: '14f5b027b0001aa1200efe98e6891853b97c450b1842255487b8da53b1b3f278',
     x86_64: '01d912a25894c2f8a532b86534d6d209e956329160a5ac9ef6131e4cf7b85a16'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
