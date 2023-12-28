require 'package'
require_relative 'llvm16_build'

class Llvm_dev16 < Package
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies. The optional packages clang, lld, lldb, polly, compiler-rt, libcxx, and libcxxabi are included.'
  homepage Llvm16_build.homepage
  version Llvm16_build.version
  license Llvm16_build.license
  compatibility Llvm16_build.compatibility

  is_fake

  depends_on 'llvm16_dev'
end
