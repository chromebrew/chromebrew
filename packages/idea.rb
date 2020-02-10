require 'package'

class Idea < Package
  description 'Capable and Ergonomic IDE for JVM'
  homepage 'https://www.jetbrains.com/idea/'
  version '2019.3.2'
  source_url 'https://download.jetbrains.com/idea/ideaIC-2019.3.2.tar.gz'
  source_sha256 'c38f18a2b2246b9a53fd62d454ccf67996bf59adc0b7e3843be0a9cf44637127'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'jdk8'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.install
    # Fix java.io.IOException: Cannot run program "/home/chronos/user/.IdeaIC2019.3/system/tmp/ij1055598732.tmp": error=13, Permission denied
    FileUtils.mkdir_p "#{CREW_DEST_HOME}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/.config/.IdeaIC2019.3"
    system "touch #{CREW_DEST_PREFIX}/.config/.IdeaIC2019.3/test"
    FileUtils.ln_s "#{CREW_PREFIX}/.config/.IdeaIC2019.3", "#{CREW_DEST_HOME}/.IdeaIC2019.3"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/Idea"
    FileUtils.mv Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/Idea"
    FileUtils.ln_s "#{CREW_PREFIX}/share/Idea/bin/idea.sh", "#{CREW_DEST_PREFIX}/bin/idea"
  end

  def self.postinstall
    puts
    puts "To get started, type 'idea'.".lightblue
    puts
    puts "To completely remove including all preferences, execute the following:".lightblue
    puts "crew remove idea".lightblue
    puts "rm -rf #{CREW_PREFIX}/.config/.IdeaIC2019.3".lightblue
    puts
  end
end
