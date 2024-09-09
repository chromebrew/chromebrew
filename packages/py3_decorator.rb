require 'buildsystems/pip'

class Py3_decorator < Pip
  description 'define signature-preserving function decorators and decorator factories'
  homepage 'https://github.com/micheles/decorator/'
  version '5.1.1-py3.12'
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dc149308c3d3cc67b959f2f141e11561b3961963b6c3393009a9d7d1104c49d5',
     armv7l: 'dc149308c3d3cc67b959f2f141e11561b3961963b6c3393009a9d7d1104c49d5',
       i686: '88fe566bb8773d947819aef03894817cc0beb30b1f65e5802628c06ea6e3a8bb',
     x86_64: '6896b33b7a9e60ef2c80d9a9e0fa17bd63df42aecb97abbce23bf620398ea039'
  })

  depends_on 'python3' => :build

  no_source_build
end
