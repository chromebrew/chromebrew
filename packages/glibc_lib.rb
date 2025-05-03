require 'package'
Package.load_package("#{__dir__}/glibc_standalone.rb")

class Glibc_lib < Package
  description 'glibc libraries'
  homepage Glibc_standalone.homepage
  license Glibc_standalone.license
  source_url 'SKIP'

  is_fake

  if LIBC_VERSION <= '2.41'
    version Glibc_standalone.version
    compatibility Glibc_standalone.compatibility
    depends_on 'glibc_standalone'
  else
    version LIBC_VERSION
    compatibility 'aarch64 armv7l x86_64'
    depends_on 'glibc_fallthrough'
  end
end
