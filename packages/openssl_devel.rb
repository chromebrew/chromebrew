require 'package'

# We are going to use openssl only instead of openssl_devel for the
# ease of maintenance.  Removing package file is not easy, so leaving
# place holder here.  PH needs to have source_url unfortunately.

class Openssl_devel < Package
  version 'removed'

  source_url 'ftp://ftp.openssl.org/source/old/1.0.2/openssl-1.0.2f.tar.gz'
  source_sha1 '2047c592a6e5a42bd37970bdb4a931428110a927'

  def self.build
  end

  def self.install
  end
end
