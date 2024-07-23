require 'package'

class Slack_cli < Package
  description 'The Slack CLI allows you to interact with your workflow apps via the command line.'
  homepage 'https://api.slack.com/automation/cli/commands'
  version '2.26.0'
  license 'MIT'
  compatibility 'all'
  source_url "https://downloads.slack-edge.com/slack-cli/slack_cli_#{version}_linux_64-bit.tar.gz"
  source_sha256 '823379cec4d4210b19dcfa00167121e8eecf489ce7adbd9b87c6dc48f26dc598'

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
