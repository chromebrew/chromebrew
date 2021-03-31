require 'package'

class Compiler_rt < Package
  description 'Compiler-rt provides highly tuned implementations of the low-level code generator support routines.'
  homepage 'https://compiler-rt.llvm.org/'
  version '11.1.0'
  license 'Apache-2.0-with-LLVM-exceptions'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project/releases/download/llvmorg-11.1.0/compiler-rt-11.1.0.src.tar.xz'
  source_sha256 'def1fc00c764cd3abbba925c712ac38860a756a43b696b291f46fee09e453274'


end
