require 'buildsystems/cmake'

class Double_conversion < CMake
  description 'Efficient binary-decimal and decimal-binary conversion routines for IEEE doubles.'
  homepage 'https://github.com/google/double-conversion'
  version '3.4.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/google/double-conversion.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7391303479ca63146017da0d7621eb66ec59b92428fc0426b7e52f45c299e089',
     armv7l: '7391303479ca63146017da0d7621eb66ec59b92428fc0426b7e52f45c299e089',
       i686: '0433179da66af03779f8fa2cac693df1c3ed32dee2e9e9cd530eacfd0041c97e',
     x86_64: '4eded468a409d7f280080b5731eea32f69fb87b886fe59adbacd23bae17908b2'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON -DBUILD_TESTING=ON'

  # Tests fail on arm and x86_64.
  # 1/9 Test #1: test_bignum.......................***Exception:   0.04 sec
  # cctest: /build/nocturne/tmp/portage/dev-libs/double-conversion-3.1.5-r1/work/double-conversion-3.1.5/double-conversion/utils.h:230: T &double_conversion::Vector<unsigned int>::operator[](int) const [T = unsigned int]: Assertion `0 <= index && index < length_' failed.
  # 2/9 Test #3: test_conversions..................***Failed    0.04 sec
  # /usr/local/tmp/crew/double_conversion.20260106074736.dir/builddir/test/cctest/cctest: symbol lookup error: /usr/local/tmp/crew/double_conversion.20260106074736.dir/builddir/test/cctest/cctest: undefined symbol: _ZNK17double_conversion23StringToDoubleConverter8StringToIdEET_PKciPi
  # 5/9 Test #9: test_strtod.......................***Exception: SegFault  0.02 sec
  # 9/9 Test #2: test_bignum_dtoa
  # 67% tests passed, 3 tests failed out of 9
  # Total Test time (real) =   1.14 sec
  # The following tests FAILED:
  # 1 - test_bignum (Subprocess aborted)
  # 3 - test_conversions (Failed)
  # 9 - test_strtod (SEGFAULT)
  # Errors while running CTest
  # run_tests
end
