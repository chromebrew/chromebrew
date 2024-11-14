require 'buildsystems/autotools'

class Daq < Autotools
  description 'Data Acquisition library, for packet I/O.'
  homepage 'https://www.snort.org'
  version '3.0.15'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/snort3/libdaq.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3c809aeb3c5663f7a3b84e573679dd5c68acb6b4f188ad7961721bf45470019f',
     armv7l: '3c809aeb3c5663f7a3b84e573679dd5c68acb6b4f188ad7961721bf45470019f',
       i686: 'cdf573c9b712ea6e17b6ac49bdd8553343aecedeb44987439f2e2428be5d4aec',
     x86_64: '1f5b8b93b32144d8c603ef13752a7ddbee93c16b5df5a0bcbacd03d5463b91fd'
  })

  # depends_on 'cmocka' => :build
  depends_on 'libpcap'

  # https://github.com/snort3/libdaq/issues/30
  # run_tests
end
