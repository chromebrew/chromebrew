require 'package'

class Llvm < Package
  llvm_build_obj = Package.load_package("#{__dir__}/#{CREW_LLVM_VER}_build.rb")
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies. The optional packages clang, lld, lldb, polly, compiler-rt, libcxx, and libcxxabi are included.'
  homepage llvm_build_obj.homepage
  version llvm_build_obj.version
  license llvm_build_obj.license
  compatibility llvm_build_obj.compatibility

  is_fake

  depends_on "#{CREW_LLVM_VER}_lib"
  depends_on "#{CREW_LLVM_VER}_dev"
end
