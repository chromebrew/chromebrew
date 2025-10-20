require 'buildsystems/pip'

class Py3_setuptools_scm < Pip
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm'
  version "9.2.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '27220e56cf272eb93896cdaaa826a5e2ebe9b0dd05eba72e91c87681ea68944e',
     armv7l: '27220e56cf272eb93896cdaaa826a5e2ebe9b0dd05eba72e91c87681ea68944e',
       i686: '32f76c1f1d0fa857d60c7f8328d8359dc8027b9e47d7458e2c24c73eb3d15057',
     x86_64: '80801753b8733c26680400820c6fcac82c4f3c159f5d4bea7dc4ba016ea0327b'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'

  no_source_build
end
