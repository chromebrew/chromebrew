require 'package'

class Pip_search < Package
  description "Replacement for the deprecated 'pip search' command."
  homepage 'https://github.com/chromebrew'
  version '1.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'xdg_utils' # R

  print_source_bashrc

  def self.preflight
    Dir.chdir("#{CREW_PREFIX}/bin") do
      abort "\nNo default browser is available.  Install your preferred browser, make it the default and then try again.\n".lightred unless File.exist?('x-www-browser') && File.symlink?('x-www-browser') && File.realpath('x-www-browser')
    end
  end

  def self.build
    File.write '10-pip_search', <<~EOF
      alias pip='function _pip(){
        if [ "$1" == "search" ]; then
          if ! test $2; then
            echo "Usage: pip search <keyword>"
          else
            pip_search "$2"
          fi;
        else pip "$@";
        fi;
      };_pip'
    EOF
    File.write 'pip_search.sh', <<~EOF
      #!/bin/bash
      if ! test $1; then
        echo "Usage: pip_search <keyword>"
        exit 1
      fi
      xdg-open "https://pypi.org/search/?q=$1"
    EOF
  end

  def self.install
    FileUtils.install 'pip_search.sh', "#{CREW_DEST_PREFIX}/bin/pip_search", mode: 0o755
    FileUtils.install '10-pip_search', "#{CREW_DEST_PREFIX}/etc/env.d/10-pip_search", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "\nType 'pip search <keyword>' to find python packages.\n"
  end
end
