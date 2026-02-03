require 'buildsystems/meson'

class Git < Meson
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  version '2.53.0'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://mirrors.edge.kernel.org/pub/software/scm/git/git-#{version.split('-').first}.tar.xz"
  source_sha256 '5818bd7d80b061bbbdfec8a433d609dc8818a05991f731ffc4a561e2ca18c653'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '814d8f63987d20480ae79f8c0c7f8d2918f10e2252ac51a4b78de2adc7dcc0d8',
     armv7l: '814d8f63987d20480ae79f8c0c7f8d2918f10e2252ac51a4b78de2adc7dcc0d8',
       i686: '290d425d864e44f5f8570dbeb45d5d142fe1f5d3673ffee179db00339278824e',
     x86_64: 'b0ebde721c958690991dec72abec51cb2d8caec1013318448824aaaa38c7022f'
  })

  depends_on 'ca_certificates' => :build
  depends_on 'curl' # R
  depends_on 'expat' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'pcre2' # R
  depends_on 'py3_asciidoc' => :build
  depends_on 'ruby_asciidoctor' => :build
  depends_on 'xmlto' => :build
  depends_on 'zlib_ng' # R

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
