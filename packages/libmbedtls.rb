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
    aarch64: '4acd217acce553dcce4686be290c8a03ba3e0fbda6d15fce541111b2b5e84435',
     armv7l: '4acd217acce553dcce4686be290c8a03ba3e0fbda6d15fce541111b2b5e84435',
       i686: 'b7b8e1b5986ef3ba7ba0c1ef2776ab69876c1ac3b43e8ef0957dc9e4b0b298e9',
     x86_64: '074c71f9c76d928cbe827ab6b902dfc65f52790e0bb183fc8995ccb2466aeb56'
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
