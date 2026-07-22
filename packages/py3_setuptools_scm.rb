require 'buildsystems/pip'

class Py3_setuptools_scm < Pip
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm'
  version "10.2.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'af767cc22cb00973e2b5ea3bfce87b87a3110394afb6316ef2f825fdf1899b0a',
     armv7l: 'af767cc22cb00973e2b5ea3bfce87b87a3110394afb6316ef2f825fdf1899b0a',
       i686: 'aefab0e05031d06b443fa6e60fa1b192549daa972105b2ffa064ed2f71e9c261',
     x86_64: 'a005feffe3f2437fdaad7f548c3a7e1ae8dae5f8650bd0ff108ee142b755f995'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'
  depends_on 'python3' => :logical

  no_source_build
end
