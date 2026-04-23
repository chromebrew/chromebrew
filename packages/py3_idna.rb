require 'buildsystems/pip'

class Py3_idna < Pip
  description 'IDNA provides internationalized domain names for Python.'
  homepage 'https://github.com/kjd/idna/'
  version "3.13-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '17e71b7009faa477d248dea4b42e9b4103d92136d8b3b503989e19449fae0f79',
     armv7l: '17e71b7009faa477d248dea4b42e9b4103d92136d8b3b503989e19449fae0f79',
       i686: '23a70e31dcaa4261cc9d6b09c60ac7331c9da342681f06f728fe0db29ba16b45',
     x86_64: '28bf97c6b95e1d74b94bbeb4c86791907aec57d2e45639dcca0934a131fb2315'
  })

  depends_on 'python3' => :logical

  no_source_build
end
