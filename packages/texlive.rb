require 'package'

class Texlive < Package
  description 'TeX Live is an easy way to get up and running with the TeX document production system.'
  homepage 'https://www.tug.org/texlive/'
  version '2017'
  source_url 'http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz'
  source_sha256 '9bc5c663bf5fb7066b4bf3c54e5ce93251923d4edaeadb485224621a02297a39'

  def self.build
  end

  def self.install
    dir = "#{CREW_DEST_PREFIX}/share/texlive"
    system "yes I | TEXLIVE_INSTALL_PREFIX=#{dir} \
           TEXLIVE_INSTALL_TEXMFVAR=#{dir}/local/texmf-var \
           TEXLIVE_INSTALL_TEXMFCONFIG=#{dir}/local/texmf-config \
           TEXLIVE_INSTALL_TEXMFHOME=#{dir}/local \
           ./install-tl --scheme=basic --no-cls"
    system "find #{dir} -iname '*.pdf' -delete" # saving some space
    system "mkdir -p #{CREW_DEST_PREFIX}/man"
    system "mv #{dir}/2017/texmf-dist/doc/man/* #{CREW_DEST_PREFIX}/man/" # copying manpages
    system "rm -rf #{dir}/2017/texmf-dist/doc"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "find #{dir}/2017/bin/ -xtype f -exec ln -rs {} #{CREW_DEST_PREFIX}/bin ';'" # linking binaries
    system "#{CREW_DEST_PREFIX}/bin/tlmgr init-usertree"
  end

  def self.postinstall
    puts "This is a very small installation, with only the basic packages. To install more, use `tlmgr install <package>`.".lightblue
  end
end
