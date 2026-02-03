require 'buildsystems/autotools'

class Tcpdump < Autotools
  description 'A powerful command-line packet analyzer.'
  homepage 'https://www.tcpdump.org/'
  version '4.99.6'
  license 'BSD'
  compatibility 'all'
  source_url "https://www.tcpdump.org/release/tcpdump-#{version}.tar.gz"
  source_sha256 '5839921a0f67d7d8fa3dacd9cd41e44c89ccb867e8a6db216d62628c7fd14b09'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '47090a61c318a62b52edb46d6c723d3fb12eeb3d14cf84a9bddbf6cc4f579948',
     armv7l: '47090a61c318a62b52edb46d6c723d3fb12eeb3d14cf84a9bddbf6cc4f579948',
       i686: '3be034a586cd674c45ab9753a1a975499a821e64d9cc4a6b3598a7a2cd901874',
     x86_64: 'd86f1c3d80365291c121caf6a8fe1ea06d776b4e3126284e8933b4527ba446ea'
  })

  depends_on 'glibc' # R
  depends_on 'libcap'
  depends_on 'libcap_ng'
  depends_on 'libpcap'
  depends_on 'openssl'

  autotools_configure_options "--with-user=#{USER}"
end
