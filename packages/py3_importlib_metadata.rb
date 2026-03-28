require 'buildsystems/pip'

class Py3_importlib_metadata < Pip
  description 'Importlib metadata reads metadata from Python packages.'
  homepage 'https://github.com/python/importlib_metadata/'
  version "9.0.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd2772f859679f78ee0d41872eda7bde23c4def169503754d876501f6cff180be',
     armv7l: 'd2772f859679f78ee0d41872eda7bde23c4def169503754d876501f6cff180be',
       i686: '248fa5330e0ae90c79ccdcd5362db8c14af539ce4119d566a53864c9aed2b6da',
     x86_64: '92ab4580d0804e729de712e793df1475b3f2c55dea30735a923a9e05cdbab196'
  })

  depends_on 'py3_zipp'
  depends_on 'python3' => :logical

  no_source_build
end
