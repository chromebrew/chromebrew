require 'buildsystems/pip'

class Py3_distlib < Pip
  description 'Distlib provides distribution utilities for Python packages.'
  homepage 'https://bitbucket.org/pypa/distlib/'
  version '0.3.8-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '33927e5415ed0f20ccbb438b8c77f2cb74250829dec66096c3aa472861849164',
     armv7l: '33927e5415ed0f20ccbb438b8c77f2cb74250829dec66096c3aa472861849164',
       i686: 'c70d9d4ce3f877d06875c8a6463ee731dc0ba7ebd8c54d2b79dba4ee4d308263',
     x86_64: '74c4eef7f08f27927096ea76b609f96e8956366513c1b1aef9529b788ce0ebb4'
  })

  depends_on 'python3' => :build

  no_source_build
end
