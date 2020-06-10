require 'package'

class Sublime_merge < Package
  description 'A snappy UI, three-way merge tool,side-by-side diffs, syntax highlighting, and more.'
  homepage 'https://www.sublimemerge.com/'
  version 'Build 1119'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'      
    source_url 'https://download.sublimetext.com/sublime_merge_build_1119_x64.tar.xz'
    source_sha256 '64b06320c0300923ade0901493cfd78e7f28598324f99d4c3609b3c85c5f1cea'
    depends_on 'sommelier'
  end

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
