require 'buildsystems/pip'

class Py3_configparser < Pip
  description 'Configparser backports newer configparser modules to earlier python versions.'
  homepage 'https://github.com/jaraco/configparser/'
  version '7.1.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd7aafde9cc652f891cbae67823c4449d350e5a3b7b9704c1542c41b0e8ad92e8',
     armv7l: 'd7aafde9cc652f891cbae67823c4449d350e5a3b7b9704c1542c41b0e8ad92e8',
       i686: '754e92b26aa3caa1199bea95f091c10ae663c18a7d6139c11d53aa211f2707da',
     x86_64: '6e91778a3fb3f7a5af6d5c9bd59888d24d931e1ecd30e7bc5022405ccf1112f1'
  })

  depends_on 'python3' => :build

  no_source_build
end
