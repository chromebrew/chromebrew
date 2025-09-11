require 'buildsystems/pip'

class Py3_readme_renderer < Pip
  description 'Safely render long_description/README files in Warehouse'
  homepage 'https://github.com/pypa/readme_renderer'
  version '44.0'
  license 'Apache'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '262fca2f2f4a0f69c88eb3de5ce5a985f648437966d231ef42aa84ba789b5409',
     armv7l: '262fca2f2f4a0f69c88eb3de5ce5a985f648437966d231ef42aa84ba789b5409',
       i686: '7f1fa9185bb6c75bb895bd9c4f7206a307d908b4396b989cc40c7a125f595cfa',
     x86_64: 'b78f6052fd8c3896c69f58b20d2100e3dcc6f12075130f32414db9dec095b8c5'
  })

  depends_on 'py3_bleach' => :build
  depends_on 'py3_docutils' => :build
  depends_on 'py3_nh3' => :build
  depends_on 'py3_pygments' => :build
  depends_on 'py3_six' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'py3_cmarkgfm' => :build
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_source_build
end
