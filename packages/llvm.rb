require 'package'
require_relative 'llvm17_build'

class Llvm < Package
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies. The optional packages clang, lld, lldb, polly, compiler-rt, libcxx, and libcxxabi are included.'
  homepage Llvm17_build.homepage.to_s
  version Llvm17_build.version.to_s
  license Llvm17_build.license
  compatibility Llvm17_build.compatibility.to_s

  is_fake

  depends_on 'llvm17_lib'
  depends_on 'llvm17_dev'
end
