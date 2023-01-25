require 'package'

class Teams < Package
  description 'Microsoft Teams - Meet, chat, call, and collaborate in just one place.'
  homepage 'https://www.microsoft.com/en-us/microsoft-teams/group-chat-software'
  @_ver = '1.5.00.10453'
  version @_ver
  license 'Freeware'
  compatibility 'x86_64'
  source_url "https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_#{@_ver}_amd64.deb"
  source_sha256 '7cb570d9ac5231eb6e6a84738e0fb1e0345863c58fe5341b2fb2db7c5e8b15f0'

  no_compile_needed

  depends_on 'libsecret'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.build
    teams = <<~EOF
      #!/bin/bash
      GDK_BACKEND=x11
      cd #{CREW_PREFIX}/share/teams
      ./teams "$@"
    EOF
    File.write('teams.sh', teams)
  end

  def self.install
    ENV['CREW_NOT_SHRINK_ARCHIVE'] = '1'
    reload_constants
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv 'share', CREW_DEST_PREFIX
    FileUtils.install 'teams.sh', "#{CREW_DEST_PREFIX}/bin/teams", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'teams' to get started.\n".lightblue
  end

  def self.remove
    config_dirs = ["#{CREW_PREFIX}/.config/Microsoft\ Teams\ -\ Preview", "#{CREW_PREFIX}/.config/Microsoft/Microsoft\ Teams"]
    config_dirs.each do |config_dir|
      next unless Dir.exist? config_dir

      system "echo '#{config_dir}'; ls '#{config_dir}'"
    end
    print "\nWould you like to remove the config directories above? [y/N] "
    case $stdin.gets.chomp.downcase
    when 'y', 'yes'
      config_dirs.each do |config_dir|
        next unless Dir.exist? config_dir

        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightred
      end
    else
      puts 'Configuration saved.'.lightgreen
    end
  end
end
