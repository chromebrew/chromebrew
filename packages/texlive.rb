require 'package'

class Texlive < Package
  description 'TeX Live is an easy way to get up and running with the TeX document production system.'
  homepage 'https://www.tug.org/texlive/'
  version '2017'
  source_url 'ftp://tug.org/historic/systems/texlive/2017/texlive-20170524-extra.tar.xz'
  source_sha256 'afe49758c26fb51c2fae2e958d3f0c447b5cc22342ba4a4278119d39f5176d7f'

  depends_on 'perl'

  def self.build
    system "rm -rf *"
    system "wget mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz"
    system "wget mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz.sha512"
    system "cat install-tl-unx.tar.gz.sha512 | xargs | cut -d' ' -f1 > sha512"
    sha512 = open('sha512').read.chomp
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA512.hexdigest( File.read('install-tl-unx.tar.gz') ) == "#{sha512}"
    system "tar xvf install-tl-unx.tar.gz"
    system "mv install-tl-2017*/* ."
    system "rm -rf install-tl-2017*/"
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
