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
    aarch64: 'e5527347435b446fd517833997b0696accd3d80bda388aa6083b8f6a9d94bbc7',
     armv7l: 'e5527347435b446fd517833997b0696accd3d80bda388aa6083b8f6a9d94bbc7',
       i686: '05d682055062cf4ca396a68272353082e80dd03da62e23604b5d6d95d667edb6',
     x86_64: '76695c2ccb8672232cd44395570c3ac3b6c15cb07ac47a377b33ea5a4f1df190'
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
