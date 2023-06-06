require 'package'
require_relative 'llvm_build16'

class Llvm < Package
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies. The optional packages clang, lld, lldb, polly, compiler-rt, libcxx, and libcxxabi are included.'
  homepage Llvm_build16.homepage.to_s
  version Llvm_build16.version.to_s
  license Llvm_build16.license
  compatibility Llvm_build16.compatibility.to_s

  is_fake

  depends_on 'llvm_lib16'
  depends_on 'llvm_dev16'
end
