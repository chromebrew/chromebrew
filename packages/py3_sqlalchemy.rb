require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.0.49-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4211c300876f1da771be59c5a28787e78104922a523544ea5b05ee03f8c0aa75',
     armv7l: '4211c300876f1da771be59c5a28787e78104922a523544ea5b05ee03f8c0aa75',
       i686: 'e47d5aba1b03ef6f660151ea0e39f5281ca6c8e7c797541b54233b79347c5982',
     x86_64: '4991b1edba08eeb85da79c21ad57f596548accb902715e346ec2c2af61a4b0e9'
  })

  depends_on 'glibc' => :library
  depends_on 'python3' => :logical

  no_source_build
end
