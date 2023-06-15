require 'package'

class Gittools < Package
  description 'Tools for analyzing .git repositories'
  homepage 'https://github.com/internetwache/GitTools'
  version '24eaef0d11e590643e65d188b017b49414d81cc2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/internetwache/GitTools.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gittools/24eaef0d11e590643e65d188b017b49414d81cc2_armv7l/gittools-24eaef0d11e590643e65d188b017b49414d81cc2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gittools/24eaef0d11e590643e65d188b017b49414d81cc2_armv7l/gittools-24eaef0d11e590643e65d188b017b49414d81cc2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gittools/24eaef0d11e590643e65d188b017b49414d81cc2_i686/gittools-24eaef0d11e590643e65d188b017b49414d81cc2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gittools/24eaef0d11e590643e65d188b017b49414d81cc2_x86_64/gittools-24eaef0d11e590643e65d188b017b49414d81cc2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '7d71cda4330eb365798fca1c44d42ac4757fcaa20c057b370f740874e3424820',
     armv7l: '7d71cda4330eb365798fca1c44d42ac4757fcaa20c057b370f740874e3424820',
       i686: 'a46f08d6556c1dda637ca1f9823bf9440b0bd0fc533b856da94242685db5a517',
     x86_64: '13973423b9d8f1f015b6d003e9627b7753b0730f805cd1e9bdc6b67b14081dc2'
  })

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
    puts 'The following tools are available:'.lightblue
    puts 'gitfinder - identifies websites with publicly accessible .git repositories'.lightblue
    puts 'gitdumper - downloads .git repositories from webservers which do not have directory listing enabled'.lightblue
    puts 'extractor - attempts to recover incomplete git repositories'.lightblue
    puts
  end
end
