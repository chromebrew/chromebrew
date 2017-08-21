require 'package'

class Megatools < Package
  description 'Megatools is a collection of programs for accessing Mega.nz service from a command line of your desktop or server.'
  homepage 'https://megatools.megous.com/'
  version '1.9.98'
  source_url 'https://megatools.megous.com/builds/megatools-1.9.98.tar.gz'
  source_sha256 '9b0521a4d27dbc417fc8e12610ac1e1da729bf6d6eb5bef927ef3670b372a16f'

  depends_on 'asciidoc'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
