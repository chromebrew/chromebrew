require 'buildsystems/pip'

class Py3_configparser < Pip
  description 'Configparser backports newer configparser modules to earlier python versions.'
  homepage 'https://github.com/jaraco/configparser/'
  version "7.3.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6cb059ca77d376698e4b228d24b9afde31286d555be2da1838830d22672e6e2d',
     armv7l: '6cb059ca77d376698e4b228d24b9afde31286d555be2da1838830d22672e6e2d',
       i686: '05f3e904b322a36ea26fb2f69740622893ad4afff1f6ee33fbae94bb933ad3c3',
     x86_64: '219ce986a9c462f7004c501dd735a935a37ff4a26c8b2d19dbe6c2e3a2a5ccef'
  })

  depends_on 'python3' => :logical

  no_source_build
end
