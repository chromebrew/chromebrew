require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "2.27.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '71a3e7fee6c09cc699bbfbc33a184801e6c74161b402a9ac27f6366ff01865c4',
     armv7l: '71a3e7fee6c09cc699bbfbc33a184801e6c74161b402a9ac27f6366ff01865c4',
       i686: 'b220c3fabc56eddbf934c4c2158a8c2b8baa79a8ac2f8efe802abb3aced06a8e',
     x86_64: 'bc37647435098784e16eabc028fdfbbc81025a96d1c1a4f437c7055579f41997'
  })

  depends_on 'python3' => :build

  no_source_build
end
