require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version '2.0.34-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6b31173fcba38941be369ede18babe8c1db8aff4f905d39daaa3f8655c3b7d9a',
     armv7l: '6b31173fcba38941be369ede18babe8c1db8aff4f905d39daaa3f8655c3b7d9a',
       i686: 'd399ffbf2dad704ce43ff685e4c6bb860736f5a56707edb032209abddf87c248',
     x86_64: '591e303e043548fbe32e0370cbaf74a9e2935dcee200c0302ebba391affdef32'
  })

  depends_on 'python3' => :build
  depends_on 'glibc' # R

  no_source_build
end
