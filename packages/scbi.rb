require 'package'

class Scbi < Package
  description 'Setup Configure Build Install - Tool to build from sources with local developers checkout support'
  homepage 'https://github.com/TurboGit/scbi'
  version '12.1'
  license 'Copyright (C) Pascal Obry'
  compatibility 'all'
  source_url 'https://github.com/TurboGit/scbi.git'
  git_hashtag "v#{version}"

  depends_on 'lsb_release'
  depends_on 'xdg_base'
  depends_on 'rsync'

  no_compile_needed
  no_fhs
  print_source_bashrc

  def self.patch
    # Set up destination locations.
    system "sed -i 's,$(HOME)/.local/bin,#{CREW_DEST_PREFIX}/bin,' Makefile"
    system "sed -i 's,$(HOME)/.config/scbi,#{CREW_DEST_PREFIX}/.config/scbi,' Makefile"
    system "sed -i 's,$(HOME)/.bash_completion.d/,#{CREW_DEST_PREFIX}/etc/bash.d/,' Makefile"
  end

  def self.install
    system 'make'
    # Fix location and remove hostname parameters.
    system "sed -i 's,$HOME/.config/scbi,#{CREW_PREFIX}/.config/scbi,' #{CREW_DEST_PREFIX}/bin/scbi"
    system "sed -i 's,hostname --domain,hostname,' #{CREW_DEST_PREFIX}/.config/scbi/6_distpkg"
    system "sed -i 's,hostname --short,hostname,' #{CREW_DEST_PREFIX}/.config/scbi/6_distpkg"
    # Download and install User Guide.
    downloader "https://github.com/TurboGit/scbi/releases/download/v#{version}/scbi.pdf",
               '9d085ede42b538a5ffc555da0d9a18619b00e094d7fdc538b1077fcac657aef5'
    FileUtils.install 'scbi.pdf', "#{CREW_DEST_PREFIX}/share/scbi/scbi.pdf", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "\nTo view the User Guide, execute 'crew install zathura && zathura #{CREW_PREFIX}/share/scbi/scbi.pdf'.\n".lightblue
  end
end
