require 'package'

class Openmp < Package
  description 'LLVM OpenMP provides an OpenMP runtime for use with the OpenMP implementation in Clang.'
  homepage 'https://openmp.llvm.org/'
  version '11.1.0'
  license 'Apache-2.0-with-LLVM-exceptions'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project/releases/download/llvmorg-11.1.0/openmp-11.1.0.src.tar.xz'
  source_sha256 'd187483b75b39acb3ff8ea1b7d98524d95322e3cb148842957e9b0fbb866052e'


end
