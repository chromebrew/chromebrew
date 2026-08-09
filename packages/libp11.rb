require 'buildsystems/autotools'

class Libp11 < Autotools
  description 'PKCS#11 wrapper library'
  homepage 'https://github.com/OpenSC/libp11'
  version '0.4.20'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/OpenSC/libp11.git'
  git_hashtag "libp11-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c35587a9a938f47a9f329ae10789c197ec94d1a17f774b8e39f444c65ccc4803',
     armv7l: 'c35587a9a938f47a9f329ae10789c197ec94d1a17f774b8e39f444c65ccc4803',
       i686: 'c1c566f74c4748834f2d6804726808bb62d093fb6af8a29f8fa173e0182edbf7',
     x86_64: '6abe2ffa009f4d22c856edf6380440f9c21531f2d4d356779176e6b052d54e01'
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
