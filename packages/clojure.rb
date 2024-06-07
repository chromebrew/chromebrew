require 'package'

class Clojure < Package
  description 'Clojure is a robust, practical, and fast programming language with a set of useful features that together form a simple, coherent, and powerful tool.'
  homepage 'https://clojure.org/'
  version '1.11.3'
  license 'EPL-1.0, Apache-2.0 and BSD'
  compatibility 'all'
  source_url 'https://github.com/clojure/clojure.git'
  git_hashtag "clojure-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '944560332940086342379caa876f578609f0ae0b609852ea4d8c1ba145c4b85f',
     armv7l: '944560332940086342379caa876f578609f0ae0b609852ea4d8c1ba145c4b85f',
       i686: '6fd46d3898db62673f38f629f7b5fb6d846fddee9d6305f8a5750f3baa849a23',
     x86_64: 'c0ffc01bf45e7ec7d75c8f7f3c2dff766426b9aa1b2e91d69387c139b747b954'
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
