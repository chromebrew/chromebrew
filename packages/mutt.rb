require 'package'

class Mutt < Package
  description 'Mutt is a small but very powerful text-based mail client for Unix operating systems.'
  homepage 'http://mutt.org/'
  version '1.8.2'
  source_url 'ftp://ftp.mutt.org/pub/mutt/mutt-1.8.2.tar.gz'
  source_sha1 'bdac1201de464d63f61a663f3dcf1ee4484dbbb3'

  def self.build
    system 'mkdir /usr/local/mail'
    system './configure --with-mailpath=/usr/local/mail --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system 'make -i install'
  end
end
