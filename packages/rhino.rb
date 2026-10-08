require 'package'

class Rhino < Package
  description 'Rhino is an open-source implementation of JavaScript written entirely in Java.'
  homepage 'https://developer.mozilla.org/en-US/docs/Mozilla/Projects/Rhino'
  version '1.9.1'
  license 'MPL-1.1 GPL-2'
  compatibility 'all'
  source_url 'https://github.com/mozilla/rhino.git'
  git_hashtag "Rhino#{version.gsub('.', '_')}_Release"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6ccff41a98164088c949c16848dbf873fd7230070a9bb3451efc0a0d6d2cd825',
     armv7l: '6ccff41a98164088c949c16848dbf873fd7230070a9bb3451efc0a0d6d2cd825',
       i686: '0189aecbd83fc245fe7444ce99c04c4f2fcbc3e1014b33c4f5d05e014ca2263e',
     x86_64: '714f7456528793ce3e97b97e6ea5883397252a748baa6a23f71b5a1f4fac9ade'
  })

  depends_on 'gradle' => :build
  depends_on 'openjdk17'

  def self.build
    File.write 'rhino.sh', <<~EOF
      #!/bin/bash
      java -jar #{CREW_PREFIX}/share/rhino/rhino.jar "$@"
    EOF
    system 'git submodule init'
    system 'git submodule update'
    system './gradlew :rhino-all:build'
  end

  def self.install
    FileUtils.install "rhino-all/build/libs/rhino-all-#{version}.jar",
                      "#{CREW_DEST_PREFIX}/share/rhino/rhino.jar", mode: 0o644
    FileUtils.install 'rhino.sh', "#{CREW_DEST_PREFIX}/bin/rhino", mode: 0o755
    FileUtils.install 'man/rhino.1', "#{CREW_DEST_MAN_PREFIX}/man1/rhino.1", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "\nType 'man rhino' to get started.\n"
  end
end
