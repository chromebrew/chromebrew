require 'package'
Package.load_package("#{__dir__}/llvm19_build.rb")

class Llvm < Package
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies. The optional packages clang, lld, lldb, polly, compiler-rt, libcxx, and libcxxabi are included.'
  homepage Llvm19_build.homepage
  version Llvm19_build.version
  license Llvm19_build.license
  compatibility Llvm19_build.compatibility

  is_fake

  depends_on 'llvm19_lib'
  depends_on 'llvm19_dev'
end
