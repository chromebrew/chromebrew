require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.7.13-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c25b19963aca705b548b6617637cd76f2c1a4c358e1d311efb80585651e390a',
     armv7l: '0c25b19963aca705b548b6617637cd76f2c1a4c358e1d311efb80585651e390a',
       i686: '43634b81a72003398bcf30993bc0505436c97948b902c10e88041fb42c9a814f',
     x86_64: '62dfa0759aeb3b1afa97478601bdfd2d5a26a58e64707d6fe740df2ea6024a49'
  })

  depends_on 'python3' => :build

  no_source_build
end
