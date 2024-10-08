require 'buildsystems/pip'

class Py3_xmltodict < Pip
  description 'XMLtoDict makes working with XML feel like you are working with JSON.'
  homepage 'https://github.com/martinblech/xmltodict/'
  version "0.14.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f98e43a9d8e86fbb6f933bc32b0ebd80cb3a4bb23a198e8923c927c2021a7ba',
     armv7l: '9f98e43a9d8e86fbb6f933bc32b0ebd80cb3a4bb23a198e8923c927c2021a7ba',
       i686: '1119115266ee6f6bfe428c8bacff42fea33b05d98719d63c9e69651703337e1a',
     x86_64: '49529249022cc4cc54a878ef915128689522c01a07df07369cb6b1ae9546b0f6'
  })

  depends_on 'python3' => :build

  no_source_build
end
