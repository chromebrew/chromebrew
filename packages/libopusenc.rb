require 'buildsystems/autotools'

class Libopusenc < Autotools
  description 'Library for encoding .opus audio files and live streams.'
  homepage 'https://github.com/xiph/libopusenc'
  version '0.2.1'
  license 'BSD 3-Clause'
  compatibility 'all'
  source_url 'https://github.com/xiph/libopusenc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e926fc1cf41c8931d1d787ce5cf75a1318656ae8833155b143d72b4ddbbe7800',
     armv7l: 'e926fc1cf41c8931d1d787ce5cf75a1318656ae8833155b143d72b4ddbbe7800',
       i686: '1aeda0691e007e7ce65411336d621fd799240fa6649e208204051cf12f5c50fc',
     x86_64: 'bc2f75a61251db88d997bcbbaa696e653240a1e4e2a1d39e28f6f84d7862b795'
  })

  depends_on 'opus'
end
