require 'package'

class Libressl < Package
  description 'LibreSSL is a version of the TLS/crypto stack forked from OpenSSL in 2014, with goals of modernizing the codebase, improving security, and applying best practice development processes.'
  homepage 'https://www.libressl.org/'
  version '1.1.1i'
  license 'ISC and openssl' # This is the actual libressl package license.
  compatibility 'all'

  is_fake

  depends_on 'openssl'

  def self.preflight
    puts
    puts 'Chromebrew\'s libressl is a fake package pointing to openssl.'.lightblue
    puts
  end
end
