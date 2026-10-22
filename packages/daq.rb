require 'buildsystems/autotools'

class Daq < Autotools
  description 'Data Acquisition library, for packet I/O.'
  homepage 'https://www.snort.org'
  version '3.0.28'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/snort3/libdaq.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8fb01256e390f2f9be2acf56b75388e9b59396bdd98a00e814747ca096db5e5d',
     armv7l: '8fb01256e390f2f9be2acf56b75388e9b59396bdd98a00e814747ca096db5e5d',
       i686: '8e68e1adb9a6450ac2dde14ec72d836452c40330a77dee9f62e06df10ed75403',
     x86_64: '896e3aa283509465d516cfd27553f81ffcf033778a2294997813c09cb9fa9e7f'
  })

  # depends_on 'cmocka' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libpcap' => :library

  # https://github.com/snort3/libdaq/issues/30
  # run_tests
end
