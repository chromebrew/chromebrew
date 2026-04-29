require 'package'

class Rubymine < Package
  description 'Ruby on Rails IDE'
  homepage 'https://www.jetbrains.com/ruby/'
  version '2026.1.1'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.28'
  # Download from https://www.jetbrains.com/ruby/download/?section=linux
  source_url "https://download.jetbrains.com/ruby/RubyMine-#{version}.tar.gz"
  source_sha256 'b5d4fc2f0b07182e635311ac44f570d557ca7ca674e6066c18bea4a6cc5c3c50'

  depends_on 'openjdk8' => :executable
  depends_on 'sommelier' => :logical
  depends_on 'xdg_base' => :logical

  no_compile_needed

  def self.preflight
    # Need at least 2gb of free disk space.
    MiscFunctions.check_free_disk_space(2147483648)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/RubyMine"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/RubyMine"
    FileUtils.ln_s "#{CREW_PREFIX}/share/RubyMine/bin/rubymine", "#{CREW_DEST_PREFIX}/bin/rubymine"
  end

  def self.postinstall
    ExitMessage.add "\nType 'rubymine' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.config/JetBrains/.RubyMine#{version.sub(/\.\d+$/, '')}")
  end
end
