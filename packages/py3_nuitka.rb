require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.7.6-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c8628600b75d494834f3e7b7f2886c65705f5a5bf34610373d3991151063bc49',
     armv7l: 'c8628600b75d494834f3e7b7f2886c65705f5a5bf34610373d3991151063bc49',
       i686: '65eae24624a271dda0305e7fa24e0ff9184ad5594913f16a1c7fae8b4988cf68',
     x86_64: '47c005e5d9c87d0cc4fa2dcb44425d41f976994fffda72d52c36d5061494425c'
  })

  depends_on 'python3' => :build

  no_source_build
end
