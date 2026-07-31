require 'buildsystems/autotools'

class Libp11 < Autotools
  description 'PKCS#11 wrapper library'
  homepage 'https://github.com/OpenSC/libp11'
  version '0.4.19'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/OpenSC/libp11.git'
  git_hashtag "libp11-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1ec82ad29ec5f69d69ed11cab8c653d53b533c9b232dcad7eba426e18cfe0a10',
     armv7l: '1ec82ad29ec5f69d69ed11cab8c653d53b533c9b232dcad7eba426e18cfe0a10',
       i686: '7978240f15d99f9c472805ad39f74424f9099e8387ec7f08eb89d3ada20359dc',
     x86_64: '83d7a908743e884d0839eaad3ad86f16cada8984eefbb0932d845fdb6a4ea100'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :library

  autotools_configure_options '--with-pkcs11-module'

  autotools_install_extras do
    # Include header files.
    FileUtils.install Dir['src/*.h'], "#{CREW_DEST_PREFIX}/include/", mode: 0o644
  end

  run_tests
end
