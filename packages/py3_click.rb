require 'buildsystems/pip'

class Py3_click < Pip
  description 'Click is a simple wrapper around optparse for powerful command line utilities.'
  homepage 'https://click.palletsprojects.com'
  version "8.5.1-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e4c8cfda8bb7eea1401606e10409875889edf2dac8eecdea58ff8d284da6d295',
     armv7l: 'e4c8cfda8bb7eea1401606e10409875889edf2dac8eecdea58ff8d284da6d295',
       i686: '0d920288c072580ac5ee7c934f703ece5a99039a0cf6d08251360f876b823746',
     x86_64: 'b213ef873ce1bd99ebb47cb611cd3b0d5cf74283b9971f369fa1d1118b8f0fe8'
  })

  depends_on 'python3' => :logical

  no_source_build
end
