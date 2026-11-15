require 'buildsystems/autotools'

class Rarian < Autotools
  description 'Documentation metadata library based on the proposed Freedesktop.org spec.'
  homepage 'https://rarian.freedesktop.org/'
  version '0.8.6'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://gitlab.freedesktop.org/rarian/rarian/-/archive/#{version}/rarian-#{version}.tar.bz2"
  source_sha256 '2dcb9a421e084511d654aa8803807ddd56560747ac37ab2fe7d84270b94084ed'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4e61c8edc87cdfbdbead29dfc360bcdbf46b804c4bc630068ae7b1ebf0c24ed4',
     armv7l: '4e61c8edc87cdfbdbead29dfc360bcdbf46b804c4bc630068ae7b1ebf0c24ed4',
       i686: '779fb792378b1c694c3f358cca9489d403b110837e65811feb2381ce5d267f0d',
     x86_64: '9e1533e82cffb9fc5eb937de733125b6e3c17aa1d99642edf972b7b555636622'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'tinyxml2' => :library
end
