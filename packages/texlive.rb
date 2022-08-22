require 'package'

class Texlive < Package
  description 'TeX Live is an easy way to get up and running with the TeX document production system.'
  homepage 'https://www.tug.org/texlive/'
  version '20210413'
  license 'GPL-2 and GPL-3'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texlive/20210413_armv7l/texlive-20210413-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texlive/20210413_armv7l/texlive-20210413-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texlive/20210413_i686/texlive-20210413-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texlive/20210413_x86_64/texlive-20210413-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2fff9cceab61498b89bca9b24f510f7cb51ecdcc84d8f7fc412d410a39a62acc',
     armv7l: '2fff9cceab61498b89bca9b24f510f7cb51ecdcc84d8f7fc412d410a39a62acc',
       i686: '87d6ddff5e594171fa65a2b7749fcb36551880267bf1fddd92118ae54a749a32',
     x86_64: '7b05daa263c6fc3a2cd1e81649b281d12d93bf9eef6c3c53267529a9dc9eec23'
  })

  def self.build
    system 'curl -#LO ftp://ftp.fu-berlin.de/tex/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz'
    system 'curl -#LO ftp://ftp.fu-berlin.de/tex/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz.sha512'
    system "cat install-tl-unx.tar.gz.sha512 | xargs | cut -d' ' -f1 > sha512"
    sha512 = open('sha512').read.chomp
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA512.hexdigest(File.read('install-tl-unx.tar.gz')) == sha512
    system 'tar xvf install-tl-unx.tar.gz'
    system 'mv install-tl-20*/* .'
    system 'rm -rf install-tl-20*/'
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

    case ARCH
    when 'armv7l', 'aaarch64'
      @archpath = 'armhf-linux'
    when 'i686'
      @archpath = 'i386-linux'
    when 'x86_64'
      @archpath = 'x86_64-linux'
    end
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    destpath = `echo #{CREW_DEST_PREFIX}/share/texlive/20*`.chomp
    path = destpath.gsub(CREW_DEST_PREFIX.to_s, CREW_PREFIX.to_s)
    @texliveenv = <<~TEXLIVEEOF
      # texlive configuration
      export PATH="$PATH:#{path}/bin/#{@archpath}"
      export MANPATH="$MANPATH:#{path}/bin/texmf-dist/doc/man"
    TEXLIVEEOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/texlive", @texliveenv)
  end

  def self.postinstall
    puts
    puts "\nThis is a very small installation, with only the basic packages. To install more, open a new shell/terminal and use `tlmgr install <package>`.".lightblue
    puts
  end
end
