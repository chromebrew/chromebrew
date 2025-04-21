require 'package'

class Llvm_dev < Package
  llvm_dev_pkg = "#{CREW_LLVM_VER}_dev"
  llvm_dev_obj = Package.load_package("#{__dir__}/#{llvm_dev_pkg}.rb")
  description llvm_dev_obj.description
  homepage llvm_dev_obj.homepage
  version llvm_dev_obj.version
  license llvm_dev_obj.license
  compatibility llvm_dev_obj.compatibility

  is_fake

  depends_on llvm_dev_pkg
end
