require 'package'

class Texlive < Package
  description 'TeX Live is an easy way to get up and running with the TeX document production system.'
  homepage 'https://www.tug.org/texlive/'
  version '20201017'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "wget ftp://ftp.fu-berlin.de/tex/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz"
    system "wget ftp://ftp.fu-berlin.de/tex/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz.sha512"
    system "cat install-tl-unx.tar.gz.sha512 | xargs | cut -d' ' -f1 > sha512"
    sha512 = open('sha512').read.chomp
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA512.hexdigest( File.read('install-tl-unx.tar.gz') ) == sha512
    system "tar xvf install-tl-unx.tar.gz"
    system "mv install-tl-20*/* ."
    system "rm -rf install-tl-20*/"
  end

  def self.install
    dir = "#{CREW_DEST_PREFIX}/share/texlive"
    system "yes I | TEXLIVE_INSTALL_PREFIX=#{dir} \
           TEXLIVE_INSTALL_TEXMFVAR=#{dir}/local/texmf-var \
           TEXLIVE_INSTALL_TEXMFCONFIG=#{dir}/local/texmf-config \
           TEXLIVE_INSTALL_TEXMFHOME=#{dir}/local \
           ./install-tl --scheme=basic --no-cls"
    system "find #{dir} -iname '*.pdf' -delete" # saving some space
    system "find #{dir}/20*/texmf-dist/doc -type f -and -not -path '*man*' -delete"
    system "find #{dir} -name 'tlmgr' -exec {} init-usertree ';'"
  end

  def self.postinstall
    path = `echo #{CREW_PREFIX}/share/texlive/20*`.chomp
    puts "\nPlease add texlive to your PATH and MANPATH to be able to use the executables and manpages. Use the following commands:".lightblue
    puts " echo \"export PATH=\$PATH:#{path}/bin/#{ARCH}-linux\" >> ~/.bashrc".lightblue
    puts " echo \"export MANPATH=\$MANPATH:#{path}/bin/texmf-dist/doc/man\" >> ~/.bashrc".lightblue
    puts " source ~/.bashrc".lightblue
    puts "\nThis is a very small installation, with only the basic packages. To install more, use `tlmgr install <package>`.".lightblue
  end
end
