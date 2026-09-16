require 'package'

class Gcc_lib < Package
  gcc_lib_pkg = "#{CREW_GCC_VER}_lib"
  gcc_lib_obj = Package.load_package("#{__dir__}/#{gcc_lib_pkg}.rb")
  description gcc_lib_obj.description
  homepage gcc_lib_obj.homepage
  version gcc_lib_obj.version
  license gcc_lib_obj.license
  compatibility gcc_lib_obj.compatibility

  is_fake

  depends_on gcc_lib_pkg
end
