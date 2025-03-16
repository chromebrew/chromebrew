require 'package'

class Nvm < Package
  description 'Node Version Manager - Simple bash script to manage multiple active node.js versions.'
  homepage 'https://github.com/nvm-sh/nvm'
  version '0.40.2'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.28'
  source_url 'https://github.com/nvm-sh/nvm.git'
  git_hashtag "v#{version}"

  no_compile_needed
  print_source_bashrc

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/nvm"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
    system "sed -i 's,$HOME/.nvm,#{CREW_DEST_PREFIX}/share/nvm,g' install.sh"
    system "sed -i 's,$(nvm_detect_profile),#{CREW_DEST_PREFIX}/etc/bash.d/10-nvm.sh,' install.sh"
    system "NVM_DIR=#{CREW_DEST_PREFIX}/share/nvm && bash install.sh"
    system "sed -i 's,#{CREW_DEST_PREFIX},#{CREW_PREFIX},' #{CREW_DEST_PREFIX}/etc/bash.d/10-nvm.sh"
    FileUtils.rm_rf Dir["#{CREW_DEST_PREFIX}/share/nvm/.git*"]
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/share/nvm/test"
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/share/nvm")
    Package.agree_to_remove("#{CREW_PREFIX}/.config/nvm")
  end
end
