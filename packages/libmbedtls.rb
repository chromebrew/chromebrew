require 'buildsystems/cmake'

class Libmbedtls < CMake
  description 'An open source, portable, easy to use, readable and flexible SSL library'
  homepage 'https://www.trustedfirmware.org/projects/mbed-tls/'
  version '4.0.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/ARMmbed/mbedtls.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1213726759c6fb3b093b71e95693c66892e7b0c2cbf82bdeec4136fe144220c9',
     armv7l: '1213726759c6fb3b093b71e95693c66892e7b0c2cbf82bdeec4136fe144220c9',
       i686: '5d62ecf51bc3329cdf377434f1ce09c29bca7988507447916d8324e5cda7a9c0',
     x86_64: 'f9d9bd8d8601deda9e6ea6c7579c58cd52418433ee7d80b92e02e98603535072'
  })

  depends_on 'glibc' # R
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

  cmake_options "-DUSE_SHARED_MBEDTLS_LIBRARY=ON -DENABLE_TESTING=#{@run_tests ? 'ON' : 'OFF'}"
end
