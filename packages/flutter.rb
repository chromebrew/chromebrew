require 'package'

class Flutter < Package
  description "Flutter is Google's UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase."
  homepage 'https://flutter.dev/'
  version '1.20.2'
  compatibility 'all'
  source_url 'https://github.com/flutter/flutter/archive/1.20.2.tar.gz'
  source_sha256 'b4086649d29f85d035ec38c27e383f8989382241331d2e352f12cc00a6b8c96b'

  depends_on 'libglu'

  def self.install
    system "git clone https://github.com/flutter/flutter.git -b #{version} --depth 1"
    FileUtils.mkdir_p CREW_DEST_HOME
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.cp_r 'flutter/', "#{CREW_DEST_PREFIX}/share"
    FileUtils.touch "#{CREW_DEST_HOME}/.flutter_tool_state"
    FileUtils.ln_sf "#{CREW_PREFIX}/share/flutter/bin/dart", "#{CREW_DEST_PREFIX}/bin/dart"
    FileUtils.ln_sf "#{CREW_PREFIX}/share/flutter/bin/flutter", "#{CREW_DEST_PREFIX}/bin/flutter"
  end

  def self.postinstall
    puts
    puts "Type 'flutter' to get started.".lightblue
    puts
    puts "To uninstall, execute the following:".lightblue
    puts "crew remove flutter".lightblue
    puts "rm -rf #{CREW_PREFIX}/share/flutter".lightblue
    puts
  end
end
