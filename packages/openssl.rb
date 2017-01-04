require 'package'

class Openssl < Package
  version '1.0.2j'

  source_url 'ftp://ftp.openssl.org/source/openssl-1.0.2j.tar.gz' # software source tarball url
  source_sha1 'bdfbdb416942f666865fa48fe13c2d0e588df54f'          # source tarball sha1 sum

  def self.build                                                  # self.build contains commands needed to build the software from source
    system './config --prefix=/usr/local'
    system 'make'                                                 # ordered chronologically
  end

  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
    system 'cd /usr/local/ssl && \                                # make sure cert.pem exists
      wget http://curl.haxx.se/ca/cacert.pem && \
      mv cacert.pem cert.pem'
  end

end
