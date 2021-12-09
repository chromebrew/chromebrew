require 'package'

class Teams < Package
  description 'Microsoft Teams - Meet, chat, call, and collaborate in just one place.'
  homepage 'https://www.microsoft.com/en-us/microsoft-teams/group-chat-software'
  @_ver = '1.4.00.26453'
  version @_ver
  license 'Freeware'
  compatibility 'x86_64'
  source_url "https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_#{@_ver}_amd64.deb"
  source_sha256 'ee15b57793aa6b79ccda744d5232da670335abd931bae2a020f5043a129ab859'

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
    IO.write('teams.sh', teams)
  end

  def self.install
    ENV['CREW_SHRINK_ARCHIVE'] = '0'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
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
    case $stdin.getc
    when 'y', 'Y'
      config_dirs.each do |config_dir|
        next unless Dir.exist? config_dir
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightred
      end
    else
      puts "Configuration saved.".lightgreen
    end
  end
end
