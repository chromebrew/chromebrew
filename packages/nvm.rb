require 'package'

class Nvm < Package
  description 'Node Version Manager - Simple bash script to manage multiple active node.js versions.'
  homepage 'https://github.com/nvm-sh/nvm'
  version '0.39.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nvm-sh/nvm.git'
  git_hashtag "v#{version}"

  no_compile_needed

  def self.install
    sed_prefix = 'sed -i "s,$HOME/.nvm,'
    sed_suffix = '/share/nvm,g" install.sh'
    system "#{sed_prefix}#{CREW_DEST_PREFIX}#{sed_suffix}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/nvm"
    system "NVM_DIR=#{CREW_DEST_PREFIX}/share/nvm && bash install.sh"
    FileUtils.rm_rf Dir["#{CREW_DEST_PREFIX}/share/nvm/.git*"]
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/share/nvm/test"
  end

  def self.postinstall
    if Gem::Version.new(LIBC_VERSION.to_s) < Gem::Version.new('2.28')
      puts "\nNode.js 18.x and above requires GLIBC 2.28.".orange
      puts "ChromeOS is currently running GLIBC #{LIBC_VERSION}.".orange
    end
    puts "\nTo finish the installation, execute the following:".lightblue
    puts "source ~/.bashrc\n".lightblue
  end

  def self.remove
    config_dir = "#{CREW_PREFIX}/share/nvm"
    if Dir.exist? config_dir
      print "Would you like to remove the #{config_dir} directory? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightblue
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
