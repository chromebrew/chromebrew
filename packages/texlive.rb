require 'package'

class Texlive < Package
  description 'TeX Live is an easy way to get up and running with the TeX document production system.'
  homepage 'https://www.tug.org/texlive/'
  version '20260301'
  license 'GPL-2 and GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.28'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6917ab894942b7f93d9874eec5a517308f919a4ee921d96c9219652ba0bfd841',
     armv7l: '6917ab894942b7f93d9874eec5a517308f919a4ee921d96c9219652ba0bfd841',
     x86_64: '0e83582364c12a63c9f20c0d8259fe62db28fac2c4ef9a3e164b8c80d65fdc0d'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libice' => :executable
  depends_on 'libsm' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxaw' => :executable
  depends_on 'libxext' => :executable
  depends_on 'libxmu' => :executable
  depends_on 'libxpm' => :executable
  depends_on 'libxt' => :executable

  no_source_build

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
    texyear = version[0..3]
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir["#{CREW_DEST_PREFIX}/share/texlive/#{texyear}/bin/#{archpath}/*"].each do |binary|
      bin = File.basename(binary)
      if bin.eql?('man')
        FileUtils.rm binary
      else
        FileUtils.ln_s "#{CREW_PREFIX}/share/texlive/#{texyear}/bin/#{archpath}/#{bin}", "#{CREW_DEST_PREFIX}/bin/#{bin}"
      end
    end
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    Dir["#{CREW_DEST_PREFIX}/share/texlive/#{texyear}/bin/#{archpath}/man/man1/*"].each do |manpage|
      man = File.basename(manpage)
      FileUtils.ln_s "#{CREW_PREFIX}/share/texlive/#{texyear}/bin/#{archpath}/man/man1/#{man}", "#{CREW_DEST_MAN_PREFIX}/man1/#{man}"
    end
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man5"
    Dir["#{CREW_DEST_PREFIX}/share/texlive/#{texyear}/bin/#{archpath}/man/man5/*"].each do |manpage|
      man = File.basename(manpage)
      FileUtils.ln_s "#{CREW_PREFIX}/share/texlive/#{texyear}/bin/#{archpath}/man/man5/#{man}", "#{CREW_DEST_MAN_PREFIX}/man5/#{man}"
    end
  end

  def self.postinstall
    ExitMessage.add <<~EOM

      This is a very small installation, with only the basic packages. To install more, open a new shell/terminal and use `tlmgr install <package>`.
    EOM
  end
end
