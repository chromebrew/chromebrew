require 'package'

class Mutt < Package
  description 'Mutt is a small but very powerful text-based mail client for Unix operating systems.'
  homepage 'http://mutt.org/'
  version '1.8.2'
  source_url 'ftp://ftp.mutt.org/pub/mutt/mutt-1.8.2.tar.gz'
  source_sha256 '1d057bf1b565f2c38ee50c9a661654cbbe4165f98e25bfa361ebbd707d96f235'

  def self.build
    system 'mkdir /usr/local/mail'
    system './configure --with-mailpath=/usr/local/mail --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system 'make -i install'
  end
end
