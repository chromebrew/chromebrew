require 'buildsystems/pip'

class Py3_dnspython < Pip
  description 'DNSPython is a DNS toolkit.'
  homepage 'https://www.dnspython.org/'
  version "2.7.0-#{CREW_PY_VER}"
  license 'ISC'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '87a115527a850e65a91c2b35c334059c0bfb665a173ac9093d1427b7e645f019',
     armv7l: '87a115527a850e65a91c2b35c334059c0bfb665a173ac9093d1427b7e645f019',
       i686: 'a82e5e9bdfb0e465324ff1f3d77ee884782f9a5d31d5e67d656d534407d2a75d',
     x86_64: 'e955959fd11244a198f2a717341a771ff96dbcf2320a79ac49d55075cd08cd9d'
  })

  depends_on 'python3' => :build

  no_source_build
end
