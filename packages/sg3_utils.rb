require 'buildsystems/autotools'

class Sg3_utils < Autotools
  description 'The sg3_utils package contains utilities that send SCSI commands to devices.'
  homepage 'https://sg.danny.cz/sg/sg3_utils.html'
  version '1.49'
  license 'BSD-2 Clause'
  compatibility 'all'
  source_url "https://sg.danny.cz/sg/p/sg3_utils-#{version}.tar.xz"
  source_sha256 '4215e7876e786dcdbf5ae14a7c0b9549b7817cdf6f5ce0debe1d1674e0d1c900'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e76663bc18d8eecb37f0bafb2f0d20a504ac0989d86d22a05c182f64bbcc72a8',
     armv7l: 'e76663bc18d8eecb37f0bafb2f0d20a504ac0989d86d22a05c182f64bbcc72a8',
       i686: 'a5b6d29a527281a0f1817cb42cea5542b24215f17cb1ddd69ef34d6a14ea34d5',
     x86_64: '2dd26011e25496934e3ddc4dc02fc476a8752c57dadcb3c147772b7cc0969b9d'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
