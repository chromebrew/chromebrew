require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.14.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2fd1401239e5b36f620521d79189c3ce93c915cffb7235f8e24f112768b336b6',
     armv7l: '2fd1401239e5b36f620521d79189c3ce93c915cffb7235f8e24f112768b336b6',
       i686: '8ed1dbeb363ea5d200fc0d256ecda2e8fab8dff378b0c2728c33730b354fdc02',
     x86_64: '88deef074a8ce0c1427bcdd0c143eb1a473f17c0aa44c7d9ee6dca135bae4453'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
