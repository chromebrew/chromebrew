require 'buildsystems/pip'

class Py3_pytz < Pip
  description 'pytz brings the Olson tz database into Python.'
  homepage 'https://pythonhosted.org/pytz/'
  @_ver = '2023.3.post1'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytz/2023.3.post1-py3.12_armv7l/py3_pytz-2023.3.post1-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytz/2023.3.post1-py3.12_armv7l/py3_pytz-2023.3.post1-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytz/2023.3.post1-py3.12_i686/py3_pytz-2023.3.post1-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytz/2023.3.post1-py3.12_x86_64/py3_pytz-2023.3.post1-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2abf8c4ba0c64ee5182a52097af744c00f8beec18fefa2ad70f28a66b1025628',
     armv7l: '2abf8c4ba0c64ee5182a52097af744c00f8beec18fefa2ad70f28a66b1025628',
       i686: '2d59ea0aff59fc0376da4f1cdda1e385475b373bd38cd2650a8e58c632460fa3',
     x86_64: '16fd6926904599b119f9ec14268b31af02fc898cc111404a26aaf127658ffcb3'
  })

  depends_on 'python3' => :build
end
