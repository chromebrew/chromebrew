require 'buildsystems/pip'

class Py3_pybind11 < Pip
  description 'Seamless operability between C++11 and Python'
  homepage 'https://github.com/pybind/pybind11'
  version '2.13.5-py3.12'
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b56730abcb0c4cdfc8dae7f7a73f73f5abe2adfb6db4afa11998551787f9eee0',
     armv7l: 'b56730abcb0c4cdfc8dae7f7a73f73f5abe2adfb6db4afa11998551787f9eee0',
       i686: 'b74b79228a19dfe47cf47405244b4a928cb1cfa6bf360cb16097403821b14489',
     x86_64: '0dec2430e1263b161abd5dd060a44b05670d5c766bb79fcaf35d730df9a7f49c'
  })

  depends_on 'python3'

  no_source_build
end
