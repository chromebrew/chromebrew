require 'buildsystems/pip'

class Py3_markdown < Pip
  description 'Markdown is a Python implementation of Markdown.'
  homepage 'https://python-markdown.github.io/'
  version "3.11-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e1d00d536540a9304ef32e82c073ee57b79f3d3204d7f6cb43b5fff64f3406d4',
     armv7l: 'e1d00d536540a9304ef32e82c073ee57b79f3d3204d7f6cb43b5fff64f3406d4',
       i686: '0883a06ba61b70b07a0467c53405cace3a18ec2e1706effc98cc3b25681c49c9',
     x86_64: '896117ae27e871fe64e7b47f47624de9c4bc8c23a8042c8eb5e12191c18e1c05'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
