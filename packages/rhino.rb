require 'package'

class Rhino < Package
  description 'Rhino is an open-source implementation of JavaScript written entirely in Java.'
  homepage 'https://developer.mozilla.org/en-US/docs/Mozilla/Projects/Rhino'
  version '1.7.10'
  source_url 'https://github.com/mozilla/rhino/archive/Rhino1_7_10_Release.tar.gz'
  source_sha256 'f8f748269032822891e8ceab6e4c4947fd42c178c3f3cedcfb4c839f0c48f543'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'jdk8'
  depends_on 'gradle' => :build

  def self.build
    system "gradle", "build", "-x", "test"
  end

  def self.install
     system "install", "-Dm644",
            "./buildGradle/libs/rhino-Rhino1_7_10_Release-1.7.10.jar",
            "#{CREW_DEST_PREFIX}/share/jdk8/lib/rhino.jar"
     system "install", "-dm755", "#{CREW_DEST_PREFIX}/share/doc/"
     system "cp", "-a",
            "./buildGradle/docs/javadoc/",
            "#{CREW_DEST_PREFIX}/share/doc/rhino-1.7.10"
  end
end
