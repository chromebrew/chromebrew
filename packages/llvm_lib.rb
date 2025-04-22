require 'package'

class Llvm_lib < Package
  llvm_lib_pkg = "#{CREW_LLVM_VER}_lib"
  llvm_lib_obj = Package.load_package("#{__dir__}/#{llvm_lib_pkg}.rb")
  description llvm_lib_obj.description
  homepage llvm_lib_obj.homepage
  version llvm_lib_obj.version
  license llvm_lib_obj.license
  compatibility llvm_lib_obj.compatibility

  is_fake

  depends_on llvm_lib_pkg
end
