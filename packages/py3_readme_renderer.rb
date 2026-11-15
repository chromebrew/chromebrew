require 'buildsystems/pip'

class Py3_readme_renderer < Pip
  description 'Safely render long_description/README files in Warehouse'
  homepage 'https://github.com/pypa/readme_renderer'
  version "46.0-#{CREW_PY_VER}"
  license 'Apache'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd628498f465fab0fab7e51b05603c5129ffa992711fab193f6135ebdb0f05d24',
     armv7l: 'd628498f465fab0fab7e51b05603c5129ffa992711fab193f6135ebdb0f05d24',
       i686: '74d31a445248d2fcecac78ad804d4810af2fe81259a87b4ebc85cb26cb098306',
     x86_64: 'cf44bbd4188a0412131cda05d829c3faa2fd0c0bdb9f4fdcd66bfe87e5ed386a'
  })

  depends_on 'py3_bleach' => :build
  depends_on 'py3_cmarkgfm' => :build
  depends_on 'py3_docutils' => :build
  depends_on 'py3_nh3' => :build
  depends_on 'py3_pygments' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'py3_six' => :build
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
