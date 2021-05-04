require 'package'

class Gittools < Package
  description 'Tools for analyzing .git repositories'
  homepage 'https://github.com/internetwache/GitTools'
  @_ver = '24eaef0d11e590643e65d188b017b49414d81cc2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/internetwache/GitTools.git'
  git_hashtag @_ver

  depends_on 'py3_requests'

  def self.build
    system "echo '#!/bin/bash' > gitfinder"
    system "echo 'if test \"\$@\"; then' >> gitfinder"
    system "echo '  python3 #{CREW_PREFIX}/bin/gitfinder.py \"\$@\"' >> gitfinder"
    system "echo 'else' >> gitfinder"
    system "echo '  python3 #{CREW_PREFIX}/bin/gitfinder.py -h' >> gitfinder"
    system "echo 'fi' >> gitfinder"
  end

  def self.install
    system "install -Dm755 Dumper/gitdumper.sh #{CREW_DEST_PREFIX}/bin/gitdumper"
    system "install -Dm755 Extractor/extractor.sh #{CREW_DEST_PREFIX}/bin/extractor"
    system "install -Dm755 Finder/gitfinder.py #{CREW_DEST_PREFIX}/bin/gitfinder.py"
    system "install -Dm755 gitfinder #{CREW_DEST_PREFIX}/bin/gitfinder"
  end

  def self.postinstall
    puts
    puts "The following tools are available:".lightblue
    puts "gitfinder - identifies websites with publicly accessible .git repositories".lightblue
    puts "gitdumper - downloads .git repositories from webservers which do not have directory listing enabled".lightblue
    puts "extractor - attempts to recover incomplete git repositories".lightblue
    puts
  end
end
