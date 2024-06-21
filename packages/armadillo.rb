require 'buildsystems/cmake'

class Armadillo < CMake
  description 'Armadillo is a high quality linear algebra library (matrix maths) for the C++ language, aiming towards a good balance between speed and ease of use'
  homepage 'https://arma.sourceforge.net/'
  version '12.8.4'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/arma/files/armadillo-12.8.4.tar.xz'
  source_sha256 '558fe526b990a1663678eff3af6ec93f79ee128c81a4c8aef27ad328fae61138'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bec07f8d03b3047ddda6ca9ba8aaa3c0471b50731b8723f1ed71e55b96443901',
     armv7l: 'bec07f8d03b3047ddda6ca9ba8aaa3c0471b50731b8723f1ed71e55b96443901',
       i686: '00690ea493007a7666bbc4351291d90ba4d40641bc80e707a1afb53fa954e0c2',
     x86_64: '68e7f1c5eab83fc334787d2bbf7a76611f15da8b90b6bdf4aca1de4643a25941'
  })

  depends_on 'arpack_ng'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glibc_lib' # R
  depends_on 'hdf5'
  depends_on 'lapack' # R
  depends_on 'openblas' # R
  depends_on 'superlu'

  def self.patch
    # We need this fix, so patch it in until its merged and available in a release.
    # [PATCH] Modify ARMA_FindARPACK.cmake to support finding libarpack64 (arpack with ILP64 support)
    downloader 'https://gitlab.com/conradsnicta/armadillo-code/-/merge_requests/137.patch', '0c1054f22bbfa7288ee4fac96654657d7f7e1a2e078ab133dfcd1992c95d6fad'
    # The patch operation fails on armv7l due to this issue: https://savannah.gnu.org/bugs/index.php?62958
    # Work around it here until patch gets a new release.
    system "#{'ulimit -n 256 &&' if ARCH.eql?('armv7l')} patch -Np1 -i 137.patch"
  end

  run_tests
end
