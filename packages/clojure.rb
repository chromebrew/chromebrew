require 'package'

class Clojure < Package
  description 'Clojure is a robust, practical, and fast programming language with a set of useful features that together form a simple, coherent, and powerful tool.'
  homepage 'https://clojure.org/'
  @_ver = '1.11.1'
  version "#{@_ver}-1"
  license 'EPL-1.0, Apache-2.0 and BSD'
  compatibility 'all'
  source_url 'https://github.com/clojure/clojure/archive/clojure-1.11.1.tar.gz'
  source_sha256 'f2fc71a53186c92a45ecb9bb4f0a3467bedcd0f9ce8eafe3bded737036e7fcfa'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c97961780791b487304a48a09d75a56fac3f5614b49303a75fedeb8e94d46933',
     armv7l: 'c97961780791b487304a48a09d75a56fac3f5614b49303a75fedeb8e94d46933',
       i686: 'a7223033ec6f8c669769e4f7adb3c7fa02c4b2748ede60fa0696299da0560528',
     x86_64: 'd6aeaf5ddcec5243c2fdf551c735ffea6cb2952935ac4ed0df54d5f812b326d0'
  })

  depends_on 'openjdk8'
  depends_on 'rlwrap'
  depends_on 'ant' => :build
  depends_on 'maven' => :build

  def self.build
    ENV['JAVA_HOME'] = CREW_PREFIX
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
