require 'package'

class Texlive < Package
  description 'TeX Live is an easy way to get up and running with the TeX document production system.'
  homepage 'https://www.tug.org/texlive/'
  version '20250308'
  license 'GPL-2 and GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '05230f304f770a1a3935af99ac87dec46e46e7fbbc1e564e26bc4b477cb1ac01',
     armv7l: '05230f304f770a1a3935af99ac87dec46e46e7fbbc1e564e26bc4b477cb1ac01',
     x86_64: '84f29639d020300c2525585fcd6f0c9fdeb118ccabc4705db2bb9069615c4302'
  })

  depends_on 'glibc' # R
  depends_on 'libice' # R
  depends_on 'libsm' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxmu' # R
  depends_on 'libxt' # R

  no_source_build
  print_source_bashrc

  def self.build
    downloader 'https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz', 'SKIP'
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
      archpath = 'armhf-linux'
    when 'i686'
      archpath = 'i386-linux'
    when 'x86_64'
      archpath = 'x86_64-linux'
    end
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    destpath = `echo #{dir}/20*`.chomp
    path = destpath.gsub(CREW_DEST_PREFIX, CREW_PREFIX)
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/texlive", <<~TEXLIVEEOF
      # texlive configuration
      export PATH="$PATH:#{path}/bin/#{archpath}"
      export MANPATH="$MANPATH:#{path}/bin/#{archpath}/man"
    TEXLIVEEOF
  end

  def self.postinstall
    ExitMessage.add <<~EOM

      This is a very small installation, with only the basic packages. To install more, open a new shell/terminal and use `tlmgr install <package>`.
    EOM
  end
end
