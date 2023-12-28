require 'package'
require_relative 'llvm17_build'

class Llvm < Package
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies. The optional packages clang, lld, lldb, polly, compiler-rt, libcxx, and libcxxabi are included.'
  homepage Llvm17_build.homepage
  version Llvm17_build.version
  license Llvm17_build.license
  compatibility Llvm17_build.compatibility

  is_fake

  depends_on 'llvm17_lib'
  depends_on 'llvm17_dev'
end
