require 'buildsystems/python'

class Scons < Python
  description 'SCons is an Open Source software construction tool that is, a next-generation build tool.'
  homepage 'https://scons.org/'
  license 'MIT'
  version '4.8.0'
  compatibility 'all'
  source_url 'https://github.com/SCons/scons.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6328b0d23b5056a824f81be896813645e63cb4109dbae4f1c8dcb9f388a2984d',
     armv7l: '6328b0d23b5056a824f81be896813645e63cb4109dbae4f1c8dcb9f388a2984d',
       i686: '5ae1eb2287b066b23d5cf294ae943dd87dd5527be04faa17e73486172227af16',
     x86_64: 'bcca5b43aa9137c288b706b750c44033c6caa1a4e8c54095cd2675f0edd77424'
  })

  depends_on 'python3'
end
