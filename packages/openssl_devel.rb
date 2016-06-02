require 'package'

#Installs JUST the headers to match the chromeos supplied libraries so that you can build things 
# that link with openssl. Needs to be kept version-synced with chromeos releases
# Could detect current version and grab one of many different packages, compare to saved
# hashes and support multiple versions if needed

#grumble - package names in crew must conform to ruby variable name restrictions. For instance '-' is disallowed
class Openssl_devel < Package
  version '1.0.2f'

#  chromeos wget can't do proper ssl negotiation with this server
#  source_url 'https://www.openssl.org/source/old/1.0.2/openssl-1.0.2f.tar.gz'
#  so use their ftp server.  
  source_url 'ftp://ftp.openssl.org/source/old/1.0.2/openssl-1.0.2f.tar.gz'
  source_sha1 '2047c592a6e5a42bd37970bdb4a931428110a927'

  depends_on 'perl'

  def self.build
    # only need to run config to get the headers set up right
    system './config'
  end

  def self.install
    out = "#{CREW_DEST_DIR}/usr/local/include/openssl"
    system "mkdir -p #{out}"

    `ls ./include/openssl`.split(' ').each do |header|
      system "cp", "./include/openssl/#{header}", out
    end

    #system "cp", "./include/openssl/*", "#{out}"
  end

end
