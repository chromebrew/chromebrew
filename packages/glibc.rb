require 'package'
require_relative 'glibc_build223'
require_relative 'glibc_build227'
require_relative 'glibc_build232'
require_relative 'glibc_build233'
require_relative 'glibc_build235'

class Glibc < Package
  description 'The GNU C Library project provides the core libraries for GNU/Linux systems.'
  homepage Glibc_build235.homepage.to_s
  license Glibc_build235.license
  compatibility Glibc_build235.compatibility.to_s

  is_fake

  case LIBC_VERSION
  when '2.23'
    version Glibc_build223.version.to_s
    compatibility Glibc_build223.compatibility.to_s
    depends_on 'glibc_build223'
  when '2.27'
    version Glibc_build227.version.to_s
    compatibility Glibc_build227.compatibility.to_s
    depends_on 'glibc_build227'
  when '2.32'
    version Glibc_build232.version.to_s
    compatibility Glibc_build232.compatibility.to_s
    depends_on 'glibc_build232'
  when '2.33'
    version Glibc_build233.version.to_s
    compatibility Glibc_build233.compatibility.to_s
    depends_on 'glibc_build233'
  when '2.35'
    version Glibc_build235.version.to_s
    compatibility Glibc_build235.compatibility.to_s
    depends_on 'glibc_lib235'
  end
end
