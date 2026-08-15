require 'buildsystems/pip'

class Py3_chardet < Pip
  description 'Chardet is a universal encoding detector.'
  homepage 'https://github.com/chardet/chardet/'
  version "7.6.0-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a1fb36691aadf5f81d49af302a3dbdab64ddfbaeac1a47cc8c75f41a04213eb6',
     armv7l: 'a1fb36691aadf5f81d49af302a3dbdab64ddfbaeac1a47cc8c75f41a04213eb6',
       i686: '9baea1730e44477b51b4e5aaf1e496886c856bf70ca8a160cd65fd06d09652db',
     x86_64: '7f3a6baecfc138939a6a8be779a22f780067add6dc2dca55e80e03cc4edfcad2'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
