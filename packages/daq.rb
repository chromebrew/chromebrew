require 'buildsystems/autotools'

class Daq < Autotools
  description 'Data Acquisition library, for packet I/O.'
  homepage 'https://www.snort.org'
  version '3.0.29'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/snort3/libdaq.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4ab5c52f5a3a3756470096374f2ebbdd80091adc0cb1e0cb1222495b986b18c3',
     armv7l: '4ab5c52f5a3a3756470096374f2ebbdd80091adc0cb1e0cb1222495b986b18c3',
       i686: 'c48d0f4566b32cce797c444fcc6b4a395df8cc80e637f4a3d18cdfa324439975',
     x86_64: 'b25f47cb7f0868c2d817f1508d88f550349fd821ea31ac08665bcc9a028d3754'
  })

  # depends_on 'cmocka' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libpcap' => :library

  # https://github.com/snort3/libdaq/issues/30
  # run_tests
end
