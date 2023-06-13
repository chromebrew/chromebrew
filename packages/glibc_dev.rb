require 'package'
require_relative 'glibc_build235'

class Glibc_dev < Package
  description 'glibc: everything except what is in glibc_lib'
  homepage Glibc_build235.homepage
  version '2.35'
  license Glibc_build235.license
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'

  is_fake

  case LIBC_VERSION
  when '2.35'
    version Glibc_build235.version.to_s
    compatibility Glibc_build235.compatibility.to_s
    depends_on 'glibc_dev235'
  end
end
