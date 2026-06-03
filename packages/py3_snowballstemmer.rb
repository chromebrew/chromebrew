require 'buildsystems/pip'

class Py3_snowballstemmer < Pip
  description 'Snowball stemming library collection for Python'
  homepage 'https://snowballstem.org'
  version "3.1.1-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '65c3bbd8260c7cf65fc3e2fee8f59c72fc211e3f3a7074e7e16ef4c9f50b9f7c',
     armv7l: '65c3bbd8260c7cf65fc3e2fee8f59c72fc211e3f3a7074e7e16ef4c9f50b9f7c',
       i686: 'fe3c3f17cba0abbcb5552a9b4f3dbfb6bca83712c4804e9b1079a39860839ec7',
     x86_64: '85461495596a8d045aeb2556287e29745f73955db7116ea21a76313a47082c83'
  })

  depends_on 'py3_pystemmer'
  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
