require 'package'

# We are going to use openssl only instead of openssl_devel for the
# ease of maintenance.  Removing package file is not easy, so leaving
# place holder here.  PH needs to have source_url unfortunately.

class Openssl_devel < Package
<<<<<<< HEAD
  version '1.0.2j'

#  chromeos wget can't do proper ssl negotiation with this server
#  source_url 'https://www.openssl.org/source/openssl-1.0.2j.tar.gz'
#  so use their ftp server.  
  source_url 'ftp://ftp.openssl.org/source/openssl-1.0.2j.tar.gz'
  source_sha1 'bdfbdb416942f666865fa48fe13c2d0e588df54f'
=======
  version 'removed'

  source_url 'ftp://ftp.openssl.org/source/old/1.0.2/openssl-1.0.2f.tar.gz'
  source_sha1 '2047c592a6e5a42bd37970bdb4a931428110a927'
>>>>>>> upstream/master

  def self.build
  end

  def self.install
  end
end
