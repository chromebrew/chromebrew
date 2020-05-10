require 'package'

class Gittools < Package
  description 'Tools for analyzing .git repositories'
  homepage 'https://github.com/internetwache/GitTools'
  version '37487'
  compatibility 'all'
  source_url 'https://github.com/internetwache/GitTools/archive/37487f603d1ba1bc5d7f7c94e9aa4b8e3beec413.tar.gz'
  source_sha256 'f445be1294a2b22dda860c8e9f8a3e891d24150b0dd591d9a0373711bf9f8b7c'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python3'

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
    Dir.chdir 'Finder' do
      system "pip3 install -r requirements.txt --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
    end
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
