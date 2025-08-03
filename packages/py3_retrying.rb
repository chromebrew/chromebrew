require 'buildsystems/pip'

class Py3_retrying < Pip
  description 'Retrying simplifies the task of adding retry behavior to just about anything.'
  homepage 'https://github.com/rholder/retrying/'
  version "1.4.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '460ba01d215ce6c492c4767a588778d85012fd0c0e274e2bb017faebd6602d25',
     armv7l: '460ba01d215ce6c492c4767a588778d85012fd0c0e274e2bb017faebd6602d25',
       i686: 'd56322c7259189ce2533ac4bd90ede1c6cec432d59ff422ebbaa67f21f2c437d',
     x86_64: '3c5e8be0957d13c9ddda4b64deb7f1e3254637d5e6332ff58c147fbb7b41efc2'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
