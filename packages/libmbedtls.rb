require 'buildsystems/cmake'

class Libmbedtls < CMake
  description 'An open source, portable, easy to use, readable and flexible SSL library'
  homepage 'https://www.trustedfirmware.org/projects/mbed-tls/'
  version '4.2.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/ARMmbed/mbedtls.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c99f6939a79bd7a836e8a666587080aa11dbf9e67171b26bd8d1f765ede22a87',
     armv7l: 'c99f6939a79bd7a836e8a666587080aa11dbf9e67171b26bd8d1f765ede22a87',
       i686: 'ef4bdb39ef1b529220c7c4b50ad1cc7c0dcb13fb7159b42ab3a30c089be07d15',
     x86_64: 'caa3daf74b261afc52636a180ccf0fa275648bfbee0d536780b8fb62c57ede17'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'py3_attrs' => :build
  depends_on 'py3_jinja2' => :build
  depends_on 'py3_jsonschema' => :build

  # Tests pass on i686, armv7l.
  # Tests fail on x86_64:
  # Total Test time (real) =  40.18 sec
  # The following tests FAILED:
  #	104 - psa_crypto_storage_format.current-suite (Failed)
  #	105 - psa_crypto_storage_format.misc-suite (Failed)
  #	106 - psa_crypto_storage_format.v0-suite (Failed)
  #	108 - psa_its-suite (Failed)

  # run_tests

  cmake_options "-DUSE_SHARED_MBEDTLS_LIBRARY=ON \
    -DLINK_WITH_PTHREAD=ON \
    -DENABLE_TESTING=#{@run_tests ? 'ON' : 'OFF'}"
end
