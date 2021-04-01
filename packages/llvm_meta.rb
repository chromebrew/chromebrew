require 'package'

class Llvm_meta < Package
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies. Metapackage.'
  homepage 'https://llvm.org/'
  version '11.1.0'
  license 'Apache-2.0-with-LLVM-exceptions'
  compatibility 'all'

  is_fake

  depends_on 'clang'
  depends_on 'clang_tools_extra'
  depends_on 'compiler_rt'
  depends_on 'flang'
  depends_on 'libclc'
  depends_on 'libcxx'
  depends_on 'lld'
  depends_on 'lldb'
  depends_on 'llvm'
  depends_on 'openmp'
  depends_on 'polly'

end
