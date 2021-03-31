require 'package'

class Libclc < Package
  description 'libclc implements the OpenCL standard library.'
  homepage 'https://libclc.llvm.org/'
  version '11.1.0'
  license 'Apache-2.0-with-LLVM-exceptions'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project/releases/download/llvmorg-11.1.0/libclc-11.1.0.src.tar.xz'
  source_sha256 '198dc45cdcc426c7968b9628a55062162ea338931157a18ddefb47188d119e1d'


end
