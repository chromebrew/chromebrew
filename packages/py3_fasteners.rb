require 'buildsystems/pip'

class Py3_fasteners < Pip
  description 'Fasteners provides useful locks for python programs.'
  homepage 'https://github.com/harlowja/fasteners/'
  version "0.20-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '757cae4f9bbdaf8280f8607312a2b0b2ca2bcce4ef2ebfd0a6f77bd8366ba784',
     armv7l: '757cae4f9bbdaf8280f8607312a2b0b2ca2bcce4ef2ebfd0a6f77bd8366ba784',
       i686: '5a81587159038cb41443f73617569c53127674b90657730902f1437027ec7699',
     x86_64: '0369ef6a7b3efa42ffedbd1b0fa1e2f51bb7167cdb2bb5731fd84cacd20016ed'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
