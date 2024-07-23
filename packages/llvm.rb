require 'package'
require_relative 'llvm18_build'

class Llvm < Package
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies. The optional packages clang, lld, lldb, polly, compiler-rt, libcxx, and libcxxabi are included.'
  homepage Llvm18_build.homepage
  version Llvm18_build.version
  license Llvm18_build.license
  compatibility Llvm18_build.compatibility

  is_fake

  depends_on 'llvm18_lib'
  depends_on 'llvm18_dev'
end
