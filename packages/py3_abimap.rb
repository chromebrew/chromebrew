require 'buildsystems/pip'

class Py3_abimap < Pip
  description 'A helper for library maintainers to use symbol versioning'
  homepage 'https://github.com/ansasaki/abimap'
  version "0.4.0-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '90403f60545cd79ac583afa0cd242b4f0a336a9ed6457bf058a0cddcbfb151c1',
     armv7l: '90403f60545cd79ac583afa0cd242b4f0a336a9ed6457bf058a0cddcbfb151c1',
       i686: 'a005276c8bedf7f54ccbf3cd63b67524e97022d5a5eb23f1a911dabff52ce575',
     x86_64: '8448ad32f77ba4d2ff1ef33e5d579ec2ae1d716eff778ce3701f8198486f5221'
  })

  depends_on 'python3' => :build

  no_source_build
end
