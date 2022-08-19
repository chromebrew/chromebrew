require 'package'

class Clojure < Package
  description 'Clojure is a robust, practical, and fast programming language with a set of useful features that together form a simple, coherent, and powerful tool.'
  homepage 'https://clojure.org/'
  version '1.11.1'
  license 'EPL-1.0, Apache-2.0 and BSD'
  compatibility 'all'
  source_url 'https://github.com/clojure/clojure/archive/clojure-1.11.1.tar.gz'
  source_sha256 'f2fc71a53186c92a45ecb9bb4f0a3467bedcd0f9ce8eafe3bded737036e7fcfa'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clojure/1.11.1_armv7l/clojure-1.11.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clojure/1.11.1_armv7l/clojure-1.11.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clojure/1.11.1_i686/clojure-1.11.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clojure/1.11.1_x86_64/clojure-1.11.1-chromeos-x86_64.tar.zst',
  })
  binary_sha256 ({
    aarch64: 'e1b089bd6e37a29749574358619ce6ca4edc6e432d85113f9ad2983295b8a5a6',
     armv7l: 'e1b089bd6e37a29749574358619ce6ca4edc6e432d85113f9ad2983295b8a5a6',
       i686: '6001c0a388d44060b7274fb0f2e50e3304c6f065d7fa783bc0a0e7ee8c1e978a',
     x86_64: '33ee033279564388ce20a037463f8f4070fe3dc83011f42a221fe49c05b0110d',
  })

  depends_on 'jdk8'
  depends_on 'rlwrap'
  depends_on 'ant' => :build
  depends_on 'maven' => :build

  def self.build
    ENV['JAVA_HOME'] = "#{CREW_PREFIX}/share/jdk8"
    clojure = <<~EOF
      #!/bin/bash
      java -jar #{CREW_PREFIX}/share/clojure/clojure.jar
    EOF
    File.write('clojure.sh', clojure)
    system './antsetup.sh'
    system 'ant local'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/clojure"
    FileUtils.install 'clojure.sh', "#{CREW_DEST_PREFIX}/bin/clojure", mode: 0o755
    FileUtils.install 'clojure.jar', "#{CREW_DEST_PREFIX}/share/clojure", mode: 0o644
  end
end
