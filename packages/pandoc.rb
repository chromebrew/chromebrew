require 'package'

class pandoc < Package
  description 'Universal markup converter'
  homepage 'https://github.com/jgm/pandoc/'
  version '2.2.1'

  depends_on 'wget'

  def self.install
    system "wget https://github.com/jgm/pandoc/releases/download/2.2.1/pandoc-2.2.1-linux.tar.gz /tmp/pandoc.tar.gz"
    system "tar xvzf /tmp/pandoc.tar.gz --strip-components 1 -C /usr/local" #Not using crew_dest in favour of the pandoc documentation's instructions
  end

  def self.postinstall
    system 'rm -rf /tmp/pandoc.tar.gz'
  end
end
