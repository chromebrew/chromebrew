require 'package'

class Sublime_merge < Package
  description 'A snappy UI, three-way merge tool,side-by-side diffs, syntax highlighting, and more.'
  homepage 'https://www.sublimemerge.com/'
  version 'Build 2063'
  license 'Copyright Sublime HQ Pty Ltd' # Shareware for evaluation purposes only.  Source code is not available.
  compatibility 'x86_64'
  source_url 'https://download.sublimetext.com/sublime_merge_build_2063_x64.tar.xz'
  source_sha256 '97abf170e210de442a3732e47f73dbb94dc3a437cb874b570a5fcb9c9b02b769'

  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/sublime_merge"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/sublime_merge/"
    FileUtils.ln_s "#{CREW_PREFIX}/share/sublime_merge/sublime_merge", "#{CREW_DEST_PREFIX}/bin/sublime_merge"
  end

  def self.postinstall
    puts
    puts 'Congratulations! You have installed Sublime Merge on Chrome OS!'.lightgreen
    puts 'Now, please run \'sublime_merge\' to start Sublime Merge.'.lightgreen
    puts
  end
end
