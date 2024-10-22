require 'buildsystems/pip'

class Py3_parsedatetime < Pip
  description 'Parse human-readable date/time strings'
  homepage 'https://github.com/bear/parsedatetime/'
  version "2.6-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '068807c3c6a9b9c97d99165ffa11a85f1776a42e67f4b95f9e05185c6bb14b6d',
     armv7l: '068807c3c6a9b9c97d99165ffa11a85f1776a42e67f4b95f9e05185c6bb14b6d',
       i686: '0875073438a18e7a36d1bd983177dc3a4894b352135fd6d0a630e90b3c1e6fbe',
     x86_64: '633f755ee02d1df038de811e08881d2cacf1174dc3358a6cb2c32b7dcf7e7e2e'
  })

  depends_on 'python3' => :build

  no_source_build
end
