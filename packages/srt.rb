require 'buildsystems/cmake'

class Srt < CMake
  description 'Secure Reliable Transport library'
  homepage 'https://www.srtalliance.org/'
  version '1.5.3'
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/Haivision/srt.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6103cdbf36e560fbab2f9efb9ae8aee535431d5b34aa22e0418df6efaa80c5aa',
     armv7l: '6103cdbf36e560fbab2f9efb9ae8aee535431d5b34aa22e0418df6efaa80c5aa',
       i686: '6db1d5c14c45227310c9eb654bf3119ea350c05298c8717b95b243331f21de6a',
     x86_64: 'ccdfbd33016503367e3d01f37953a9746d31b75547ecfa3ea26593782bc46bf9'
  })

  depends_on 'openssl'
end
