require 'package'
require_relative 'openssl'

class Libressl < Package
  description 'LibreSSL is a version of the TLS/crypto stack forked from OpenSSL in 2014, with goals of modernizing the codebase, improving security, and applying best practice development processes.'
  homepage 'https://www.libressl.org/'
  version Openssl.version
  license Openssl.license
  compatibility Openssl.compatibility

  is_fake

  depends_on 'openssl'

  def self.postinstall
    puts "\nLibressl is a fake package pointing to openssl.\n".lightblue
  end
end
