require 'buildsystems/pip'

class Py3_importlib_metadata < Pip
  description 'Importlib metadata reads metadata from Python packages.'
  homepage 'https://github.com/python/importlib_metadata/'
  version "10.2.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c09ca68bcbd09ea16c3ac904c50c43f52790ba1213775ada1aa0427678e8188e',
     armv7l: 'c09ca68bcbd09ea16c3ac904c50c43f52790ba1213775ada1aa0427678e8188e',
       i686: '4db88e278591096be22f7eb5100f026fce7b05ff8fc8a00dfe551384587fb4f9',
     x86_64: 'eb278ee797363324fcecc799a8e3158c425b4dd63f3f14653aa60e7fa216327a'
  })

  depends_on 'py3_zipp'
  depends_on 'python3' => :logical

  no_source_build
end
