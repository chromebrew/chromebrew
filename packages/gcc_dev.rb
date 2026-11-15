require 'package'

class Gcc_dev < Package
  gcc_dev_pkg = "#{CREW_GCC_VER}_dev"
  gcc_dev_obj = Package.load_package("#{__dir__}/#{gcc_dev_pkg}.rb")
  description gcc_dev_obj.description
  homepage gcc_dev_obj.homepage
  version gcc_dev_obj.version
  license gcc_dev_obj.license
  compatibility gcc_dev_obj.compatibility

  is_fake

  depends_on gcc_dev_pkg
end
