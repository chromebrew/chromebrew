require 'buildsystems/pip'

class Py3_imagesize < Pip
  description 'Imagesize gets image size from png/jpeg/jpeg2000/gif file.'
  homepage 'https://github.com/shibukawa/imagesize_py/'
  version '1.4.1-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_source_build
end
