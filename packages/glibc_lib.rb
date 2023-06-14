require 'package'
require_relative 'glibc'
require_relative 'glibc_build235'

class Glibc_lib < Package
  description 'glibc libraries'
  homepage Glibc.homepage
  license Glibc.license
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
