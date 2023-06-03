require 'package'
require_relative 'llvm_build'

class Llvm < Package
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies. The optional packages clang, lld, lldb, polly, compiler-rt, libcxx, and libcxxabi are included.'
  homepage Llvm_build.homepage.to_s
  version Llvm_build.version.to_s
  license Llvm_build.license
  compatibility Llvm_build.compatibility.to_s

  is_fake

  depends_on 'llvm_libs'
  depends_on 'llvm_bin'
end
