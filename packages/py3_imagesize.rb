require 'buildsystems/pip'

class Py3_imagesize < Pip
  description 'Imagesize gets image size from png/jpeg/jpeg2000/gif file.'
  homepage 'https://github.com/shibukawa/imagesize_py/'
  version "1.4.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '496b7868dcafd439f2be6c27e1a350b548c0dd3f64cdee6b54271583b7c1e752',
     armv7l: '496b7868dcafd439f2be6c27e1a350b548c0dd3f64cdee6b54271583b7c1e752',
       i686: '7ebc51e0b85ffb843ddde88ccf251a3a1b65dc60659bf6c768732f76e421b9f2',
     x86_64: '2f3268ed82f81bc099dc072c910ce4dfec7618283c9314f69ae67705fc447c3b'
  })

  depends_on 'python3' => :build

  no_source_build
end
