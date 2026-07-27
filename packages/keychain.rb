require 'package'

class Keychain < Package
  description 'Keychain helps you to manage SSH and GPG keys in a convenient and secure manner.'
  homepage 'https://www.funtoo.org/Keychain'
  version '3.0.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/funtoo/keychain.git'
  git_hashtag version

  no_compile_needed
  print_source_bashrc

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/keychain"
    FileUtils.install 'keychain', "#{CREW_DEST_PREFIX}/bin/keychain"
    FileUtils.install 'keychain.1', "#{CREW_DEST_MAN_PREFIX}/man1/keychain.1"
    FileUtils.install 'completions/keychain.bash', "#{CREW_DEST_PREFIX}/etc/bash.d/10-keychain", mode: 0o644
    FileUtils.rm_rf %w[.gitignore keychain keychain.1 keychain.1.orig keychain.spec.in keychain.spec keychain.pod Makefile]
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/keychain"
  end
end
