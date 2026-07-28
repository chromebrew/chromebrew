require 'package'

class Keychain < Package
  description 'Keychain helps you to manage SSH and GPG keys in a convenient and secure manner.'
  homepage 'https://www.funtoo.org/Keychain'
  version '3.0.1'
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
    FileUtils.install 'keychain.pyz', "#{CREW_DEST_PREFIX}/bin/keychain"
  end
end
