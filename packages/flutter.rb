require 'package'

class Flutter < Package
  description "Flutter is Google's UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase."
  homepage 'https://flutter.dev/'
  version '2.2.3'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/flutter/flutter.git'
  git_hashtag version

  depends_on 'libglu'

  def self.build
    system 'bin/flutter'
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_HOME
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/flutter"
    FileUtils.cp_r Dir['.'], "#{CREW_DEST_PREFIX}/share/flutter"
    FileUtils.touch "#{CREW_DEST_HOME}/.flutter_tool_state"
    unless File.exist? "#{CREW_PREFIX}/bin/dart"
      FileUtils.ln_sf "#{CREW_PREFIX}/share/flutter/bin/dart", "#{CREW_DEST_PREFIX}/bin/dart"
    end
    FileUtils.ln_sf "#{CREW_PREFIX}/share/flutter/bin/flutter", "#{CREW_DEST_PREFIX}/bin/flutter"
  end

  def self.postinstall
    puts "\nType 'flutter' to get started.\n".lightblue
  end

  def self.remove
    print "Would you like to remove the config directories? [y/N] "
    response = STDIN.getc
    config_dirs = ["#{HOME}/.flutter", "#{CREW_PREFIX}/share/flutter"]
    config_dirs.each { |config_dir|
      if Dir.exists? config_dir
        case response
        when "y", "Y"
          FileUtils.rm_rf config_dir
          puts "#{config_dir} removed.".lightred
        else
          puts "#{config_dir} saved.".lightgreen
        end
      end
    }
  end
end
