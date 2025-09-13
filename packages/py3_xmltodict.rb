require 'buildsystems/pip'

class Py3_xmltodict < Pip
  description 'XMLtoDict makes working with XML feel like you are working with JSON.'
  homepage 'https://github.com/martinblech/xmltodict/'
  version "1.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f896ba19716a2df530b7c7ca2a096742558e13de509fddb4c484a41d394ec1bb',
     armv7l: 'f896ba19716a2df530b7c7ca2a096742558e13de509fddb4c484a41d394ec1bb',
       i686: '602bc18be0507014292aa5c5908accf2f84f9a86b9811afdc7b1309f7e63f136',
     x86_64: 'e0d6c3576a80a45260043dd1fe6f166abfc5a3a61a4d87f2ea3bed33d947432f'
  })

  depends_on 'python3' => :build

  no_source_build
end
