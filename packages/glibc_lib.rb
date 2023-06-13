require 'package'
require_relative 'glibc_build235'
require_relative 'glibc'

class Glibc_lib < Package
  description 'glibc libraries'
  homepage Glibc_build235.homepage
  version '2.35' # Do not use @_ver here, it will break the installer.
  license Glibc_build235.license
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'

  is_fake

  case LIBC_VERSION
  when '2.35'
    version Glibc_build235.version.to_s
    compatibility Glibc_build235.compatibility.to_s
    depends_on 'glibc_lib235'
  else
    version Glibc.version.to_s
    compatibility Glibc.compatibility.to_s
    depends_on 'glibc'
  end
end
