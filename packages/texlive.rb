require 'package'

class Texlive < Package
  description 'TeX Live is an easy way to get up and running with the TeX document production system.'
  homepage 'https://www.tug.org/texlive/'
  version '2017'
  compatibility 'all'
  source_url 'ftp://tug.org/historic/systems/texlive/2017/texlive-20170524-extra.tar.xz'
  source_sha256 'afe49758c26fb51c2fae2e958d3f0c447b5cc22342ba4a4278119d39f5176d7f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/texlive-2017-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/texlive-2017-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/texlive-2017-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/texlive-2017-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bb40fc919fcbb9448c484701d86243d018c4644281d6fa8ba5a38773e6889488',
     armv7l: 'bb40fc919fcbb9448c484701d86243d018c4644281d6fa8ba5a38773e6889488',
       i686: '413154155e75db6e04530fe1493bfacfd0893837ed3e005675a8d1eb339d5fb6',
     x86_64: 'b8d927bc0abb8a17a440d235459a90cb50a49c343b8f0a43c9be853cbe0f26b3',
  })

  depends_on 'perl'

  def self.build
    system "rm -rf *"
    system "wget ftp://ftp.fu-berlin.de/tex/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz"
    system "wget ftp://ftp.fu-berlin.de/tex/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz.sha512"
    system "cat install-tl-unx.tar.gz.sha512 | xargs | cut -d' ' -f1 > sha512"
    sha512 = open('sha512').read.chomp
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA512.hexdigest( File.read('install-tl-unx.tar.gz') ) == "#{sha512}"
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
