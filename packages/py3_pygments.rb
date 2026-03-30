require 'buildsystems/pip'

class Py3_pygments < Pip
  description 'Python Syntax Highlighter'
  homepage 'https://pygments.org/'
  version "2.20.0-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9fd1bf90d3111d0d385cbaf7d5c8132096699ffd6ebbe7c2e1ba6641f1f8842d',
     armv7l: '9fd1bf90d3111d0d385cbaf7d5c8132096699ffd6ebbe7c2e1ba6641f1f8842d',
       i686: '7de4f9d17baeae1bbc51c20c6f4746a4c3a53f893f385ea525a4972cb5ec54a5',
     x86_64: 'fe427836a5c6ce2590e71bbeb48a80e174b82eb60a90d27fe90390c091171bf3'
  })

  depends_on 'python3' => :logical

  no_source_build
end
