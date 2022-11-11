require 'package'

class Sublime_merge < Package
  description 'A snappy UI, three-way merge tool,side-by-side diffs, syntax highlighting, and more.'
  homepage 'https://www.sublimemerge.com/'
  version 'Build 2077'
  license 'Copyright Sublime HQ Pty Ltd' # Shareware for evaluation purposes only.  Source code is not available.
  compatibility 'x86_64'
  source_url 'https://download.sublimetext.com/sublime_merge_build_2077_x64.tar.xz'
  source_sha256 'eb1821fe849ab536070a74045e2640a07b37c88d628a62ccb730a8b01281569f'

  depends_on 'sommelier'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/sublime_merge"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/sublime_merge/"
    FileUtils.ln_s "#{CREW_PREFIX}/share/sublime_merge/sublime_merge", "#{CREW_DEST_PREFIX}/bin/sublime_merge"
  end

  def self.postinstall
    puts "\nCongratulations! You have installed Sublime Merge on Chrome OS!".lightgreen
    puts "Now, please run 'sublime_merge' to get started.\n".lightgreen
  end
end
