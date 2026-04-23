require 'buildsystems/pip'

class Py3_wheel < Pip
  description 'Wheel is the binary package format for python.'
  homepage 'https://wheel.readthedocs.io/'
  version "0.47.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5a0caaff9172505342757357c7c7f1dc69ca7b41446277ae4d304703f2d49a02',
     armv7l: '5a0caaff9172505342757357c7c7f1dc69ca7b41446277ae4d304703f2d49a02',
       i686: '705467d1744116383410792ca8939ff5c0957b79c448ef18deab9a0412206445',
     x86_64: '0dd2f5ed4c4b00dcc3c56816704b37c6e7d58200b63b7afe221c6e2af53825a8'
  })

  depends_on 'py3_packaging'
  depends_on 'python3' => :logical

  no_source_build
end
