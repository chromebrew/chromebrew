require 'package'

class Tuptime < Package
  description 'Report historical and statistical real time of the system, keeping it between restarts.'
  homepage 'https://github.com/rfmoz/tuptime'
  version '5.2.3'
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/rfmoz/tuptime.git'
  git_hashtag version

  no_compile_needed

  def self.patch
    system "sed -i 's,/var/lib,#{CREW_PREFIX}/var/lib,' src/tuptime"
  end

  def self.install
    FileUtils.install 'src/tuptime', "#{CREW_DEST_PREFIX}/bin/tuptime", mode: 0o755
  end

  def self.remove
    config_dir = "#{CREW_PREFIX}/var/lib/tuptime"
    if Dir.exist? config_dir
      puts "WARNING: This will remove #{CREW_PREFIX}/var/lib/tuptime/tuptime.db and all your history.".orange
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
