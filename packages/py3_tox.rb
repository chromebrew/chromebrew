require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.67.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1b643f848e21c3b1eaaff8cd77aeebdeed4617bf82b3a4e308176b05f2ae36f0',
     armv7l: '1b643f848e21c3b1eaaff8cd77aeebdeed4617bf82b3a4e308176b05f2ae36f0',
       i686: 'f9f236441c6e728dd5fdbc13dd8988b2e5b108707c35e1c236b9c41bc71bdd2d',
     x86_64: '3db4b426080fa298af3b4b96187232a364a704504f1ba9e69b490d689d43b738'
  })

  depends_on 'py3_filelock'
  depends_on 'py3_packaging'
  depends_on 'py3_pluggy'
  depends_on 'py3_py'
  depends_on 'py3_six'
  depends_on 'py3_toml'
  depends_on 'py3_virtualenv'
  depends_on 'python3' => :logical

  no_source_build
end
