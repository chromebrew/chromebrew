require 'package'

class Texlive < Package
  description 'TeX Live is an easy way to get up and running with the TeX document production system.'
  homepage 'https://www.tug.org/texlive/'
  version '20201101-1'
  license 'metapackage'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  def self.build
    system "curl -#LO ftp://ftp.fu-berlin.de/tex/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz"
    system "curl -#LO ftp://ftp.fu-berlin.de/tex/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz.sha512"
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

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    path = `echo #{CREW_PREFIX}/share/texlive/20*`.chomp
    @env = <<~EOF
      # texlive configuration
      export PATH="$PATH:#{path}/bin/#{ARCH}-linux"
      export MANPATH="$MANPATH:#{path}/bin/texmf-dist/doc/man"
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/FIXME", @env)
  end

  def self.postinstall
    puts
    puts "\nThis is a very small installation, with only the basic packages. To install more, use `tlmgr install <package>`.".lightblue
    puts
  end
end
