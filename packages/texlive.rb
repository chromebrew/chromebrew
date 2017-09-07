require 'package'

class Texlive < Package
  description 'TeX Live is an easy way to get up and running with the TeX document production system.'
  homepage 'https://www.tug.org/texlive/'
  version '2017'
  source_url 'ftp://ftp.fu-berlin.de/tex/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz'
  source_sha256 '1e09ffe84046af5fa68c788a3fd3c517f9c7e131d9d08603e2856cba22adf36e'

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
    system "find #{dir}/2017/texmf-dist/doc -type f -and -not -path '*man*' -delete"
    system "find #{dir} -name 'tlmgr' -exec {} init-usertree ';'"
  end

  def self.postinstall
    puts "\nPlease add texlive to your PATH and MANPATH to be able to use the executables and manpages. Use the following commands:".lightblue
    puts " echo \"export PATH=\$PATH:#{CREW_PREFIX}/share/texlive/2017/bin/#{ARCH}-linux\" >> ~/.bashrc".lightblue
    puts " echo \"export MANPATH=\$MANPATH:#{CREW_PREFIX}/share/texlive/2017/bin/texmf-dist/doc/man\" >> ~/.bashrc".lightblue
    puts " source ~/.bashrc".lightblue
    puts "\nThis is a very small installation, with only the basic packages. To install more, use `tlmgr install <package>`.".lightblue
  end
end
