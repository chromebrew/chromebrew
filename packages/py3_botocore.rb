require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.25-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd70b762a8240b308355919f5214fe66fd19c1ba6c777823bd6e02d6d375d4135',
     armv7l: 'd70b762a8240b308355919f5214fe66fd19c1ba6c777823bd6e02d6d375d4135',
       i686: 'fd85738070c53a23f83be228b6409b20812dc8500d9de98a6b616b709e752334',
     x86_64: 'c4e5e7ee018ae4b3ebc76a1cbb3ce6cb561b66548076ea319946b89e352b7e4f'
  })

  depends_on 'python3' => :logical

  no_source_build
end
