require 'package'

class Llvm_libunwind_11 < Package
  description 'libunwind provides a family of _Unwind_* functions implementing the language-neutral stack.'
  homepage 'https://clang.llvm.org/'
  version '11.1.0'
  license 'Apache-2.0-with-LLVM-exceptions'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project/releases/download/llvmorg-11.1.0/libunwind-11.1.0.src.tar.xz'
  source_sha256 'd29eb112d6f388a05e7fd5315923a5528489ddfc55a21cf27268a33298d0f8ee'


end
