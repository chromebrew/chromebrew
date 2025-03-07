require 'package'
Package.load_package("#{__dir__}/llvm20_build.rb")

class Llvm < Package
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies. The optional packages clang, lld, lldb, polly, compiler-rt, libcxx, and libcxxabi are included.'
  homepage Llvm20_build.homepage
  version Llvm20_build.version
  license Llvm20_build.license
  compatibility Llvm20_build.compatibility

  is_fake

  depends_on 'llvm20_lib'
  depends_on 'llvm20_dev'
end
