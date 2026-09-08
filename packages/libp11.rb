require 'buildsystems/autotools'

class Libp11 < Autotools
  description 'PKCS#11 wrapper library'
  homepage 'https://github.com/OpenSC/libp11'
  version '0.4.21'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/OpenSC/libp11.git'
  git_hashtag "libp11-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '91ae06221014607ccca85c2629d1e2a5518654f1336ae38fb36662cb4536b08a',
     armv7l: '91ae06221014607ccca85c2629d1e2a5518654f1336ae38fb36662cb4536b08a',
       i686: 'bbe225c3d985716127aa39dccbfec8625e31b54da49d6175f619548b8798347c',
     x86_64: '7517fd0849d7938925172e3323ac6c582d127161899bfbe706c067f07b4454ff'
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
