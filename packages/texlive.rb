require 'package'

class Texlive < Package
  description 'TeX Live is an easy way to get up and running with the TeX document production system.'
  homepage 'https://www.tug.org/texlive/'
  version '20230319'
  license 'GPL-2 and GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.28'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texlive/20230319_armv7l/texlive-20230319-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texlive/20230319_armv7l/texlive-20230319-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texlive/20230319_x86_64/texlive-20230319-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5136c02c438be3d419c50990a058cde110a0dd144088d6c650e0dc6bedae037e',
     armv7l: '5136c02c438be3d419c50990a058cde110a0dd144088d6c650e0dc6bedae037e',
     x86_64: '9dc5195868f9de7afa9804028dec264e2926fda6966792e941c19a7154d28dce'
  })

  depends_on 'glibc' # R
  depends_on 'libice' # R
  depends_on 'libsm' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxmu' # R
  depends_on 'libxt' # R

  def self.build
    system 'curl -#LO https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz'
    system 'curl -#LO https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz.sha512'
    system "cat install-tl-unx.tar.gz.sha512 | xargs | cut -d' ' -f1 > sha512"
    sha512 = open('sha512').read.chomp
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA512.hexdigest(File.read('install-tl-unx.tar.gz')) == sha512
    system 'tar --strip-components=1 -xf install-tl-unx.tar.gz'
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
    path = destpath.gsub(CREW_DEST_PREFIX, CREW_PREFIX)
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
