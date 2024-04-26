require 'package'

class Slack_cli < Package
  description 'The Slack CLI allows you to interact with your workflow apps via the command line.'
  homepage 'https://api.slack.com/automation/cli/commands'
  version '2.22.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://downloads.slack-edge.com/slack-cli/slack_cli_2.22.0_linux_64-bit.tar.gz'
  source_sha256 '6416ca1a03c6ac161c961ead9056dbb833f6361049c7b6b12fc577983acef4fb'

  depends_on 'git' # R

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'bin/slack', "#{CREW_DEST_PREFIX}/bin/slack", mode: 0o755
  end

  def self.remove
    config_dir = "#{HOME}/.slack"
    if Dir.exist? config_dir
      print "Would you like to remove the #{config_dir} directory? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightgreen
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
