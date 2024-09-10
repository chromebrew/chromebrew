require 'buildsystems/pip'

class Py3_pyudev < Pip
  description 'Pyudev provides Python bindings for udev.'
  homepage 'https://pyudev.readthedocs.io/'
  version '0.24.3-py3.12'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b23bae747d222b4ef9ab385a9f0f594cd57f13d319d9df6fe275b0936cb1c2b4',
     armv7l: 'b23bae747d222b4ef9ab385a9f0f594cd57f13d319d9df6fe275b0936cb1c2b4',
       i686: '0b68d9b207d896e09169b2046e1922bed69ed3627c57ca9830b8e9f47ce5c5bb',
     x86_64: '1a67d5e6bf1ff591fb57e2ed82abcfa441db0b98bf05d8e70c829d8c56eed533'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
