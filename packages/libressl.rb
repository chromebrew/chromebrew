require 'package'
require_relative 'openssl'

class Libressl < Package
  description 'LibreSSL is a version of the TLS/crypto stack forked from OpenSSL in 2014, with goals of modernizing the codebase, improving security, and applying best practice development processes.'
  homepage 'https://www.libressl.org/'
  version Openssl.version.to_s
  license Openssl.license.to_s
  compatibility Openssl.compatibility.to_s

  is_fake

  depends_on 'openssl'

  def self.postinstall
    puts "\nLibressl is a fake package pointing to openssl.\n".lightblue
  end
end
