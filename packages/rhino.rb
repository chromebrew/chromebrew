require 'package'

class Rhino < Package
  description 'Rhino is an open-source implementation of JavaScript written entirely in Java.'
  homepage 'https://developer.mozilla.org/en-US/docs/Mozilla/Projects/Rhino'
  version '1.7.10'
  compatibility 'all'
  source_url 'https://github.com/mozilla/rhino/archive/Rhino1_7_10_Release.tar.gz'
  source_sha256 'f8f748269032822891e8ceab6e4c4947fd42c178c3f3cedcfb4c839f0c48f543'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rhino-1.7.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rhino-1.7.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/rhino-1.7.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rhino-1.7.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6ccff41a98164088c949c16848dbf873fd7230070a9bb3451efc0a0d6d2cd825',
     armv7l: '6ccff41a98164088c949c16848dbf873fd7230070a9bb3451efc0a0d6d2cd825',
       i686: '0189aecbd83fc245fe7444ce99c04c4f2fcbc3e1014b33c4f5d05e014ca2263e',
     x86_64: '714f7456528793ce3e97b97e6ea5883397252a748baa6a23f71b5a1f4fac9ade',
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
