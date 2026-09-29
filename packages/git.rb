require 'buildsystems/meson'

class Git < Meson
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  version '2.56.0'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://mirrors.edge.kernel.org/pub/software/scm/git/git-#{version}.tar.xz"
  source_sha256 '26c56c296b38c0695b26fa95f475f1d01704d2d38e73465ca30b0b2f5dc789d3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6557fa83bf9c652764cc83064e341b0f9878c88187da639bd699488c1036e472',
     armv7l: '6557fa83bf9c652764cc83064e341b0f9878c88187da639bd699488c1036e472',
       i686: '0ba3ae373484b62bdf33a06a006550311bd69410fb127abd2f5a60d4c5e8a32a',
     x86_64: '7ded3eaf98f4d9add09e36df25ef1487f28ff263525fb108c27fa77930293d97'
  })

  depends_on 'ca_certificates' => :build
  depends_on 'curl' => :executable
  depends_on 'expat' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :build
  depends_on 'glibc_lib' => :executable
  depends_on 'openssl' => :executable
  depends_on 'pcre2' => :executable
  depends_on 'py3_asciidoc' => :build
  depends_on 'ruby_asciidoctor' => :build
  depends_on 'xmlto' => :build
  depends_on 'zlib_ng' => :executable

  print_source_bashrc
  run_tests

  meson_options "-Ddefault_pager=most \
        -Ddocs=man \
        -Dgitattributes=#{CREW_PREFIX}/etc/gitattributes \
        -Dgitconfig=#{CREW_PREFIX}/etc/gitconfig \
        -Dgitweb=disabled \
        #{'-Drust=disabled' if ARCH == 'armv7l'} \
        -Dsane_tool_path=#{CREW_PREFIX}/bin \
        -Dzlib_backend=zlib-ng"

  meson_build_extras do
    git_env = <<~EOF

      GIT_PS1_SHOWDIRTYSTATE=yes
      GIT_PS1_SHOWSTASHSTATE=yes
      GIT_PS1_SHOWUNTRACKEDFILES=yes
      GIT_PS1_SHOWUPSTREAM=auto
      GIT_PS1_DESCRIBE_STYLE=default
      GIT_PS1_SHOWCOLORHINTS=yes

      # Add LIBC_VERSION and CHROMEOS_RELEASE_CHROME_MILESTONE set in
      # crew_profile_base to prompt if in a container.
      if [[ -e /.dockerenv ]] && [ -n "${LIBC_VERSION+1}" ] && [ -n "${CHROMEOS_RELEASE_CHROME_MILESTONE+1}" ]; then
        PS1='\\[\\033[1;34m\\]\\u@\\H:$LIBC_VERSION M$CHROMEOS_RELEASE_CHROME_MILESTONE \\[\\033[1;33m\\]\\w \\[\\033[1;31m\\]$(__git_ps1 "(%s)")\\[\\033[0m\\]\\$ '
      else
        PS1='\\[\\033[1;34m\\]\\u@\\H \\[\\033[1;33m\\]\\w \\[\\033[1;31m\\]$(__git_ps1 "(%s)")\\[\\033[0m\\]\\$ '
      fi
    EOF
    File.write('contrib/completion/git-prompt.sh', git_env, mode: 'a')
  end

  meson_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/git-completion"
    FileUtils.cp_r Dir.glob('contrib/completion/.'), "#{CREW_DEST_PREFIX}/share/git-completion/"

    File.write 'git_bashd_env', <<~GIT_BASHD_EOF
      # git bash completion
      source #{CREW_PREFIX}/share/git-completion/git-completion.bash
    GIT_BASHD_EOF
    FileUtils.install 'git_bashd_env', "#{CREW_DEST_PREFIX}/etc/bash.d/git", mode: 0o644
    FileUtils.install 'contrib/completion/git-prompt.sh', "#{CREW_DEST_PREFIX}/etc/bash.d/git-prompt.sh", mode: 0o644
  end

  def self.check
    # Check to see if linking libcurl worked, which means
    # git-remote-https should exist
    unless File.symlink?("#{CREW_DEST_PREFIX}/libexec/git-core/git-remote-https") ||
           File.exist?("#{CREW_DEST_PREFIX}/libexec/git-core/git-remote-https")
      abort 'git-remote-https is broken'.lightred
    end
  end

  def self.postinstall
    ExitMessage.add "\ncd /path/to/git/repo and you should see the branch displayed in the prompt.\n".lightblue
    return unless File.directory?("#{CREW_PREFIX}/lib/crew/.git")

    puts 'Running git garbage collection...'.lightblue
    system 'git gc', chdir: CREW_LIB_PATH, exception: false
  end
end
