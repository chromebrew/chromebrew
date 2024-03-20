require 'package'

class Clear_cache < Package
  description 'Script to remove system cache files'
  homepage 'https://github.com/chromebrew/chromebrew/wiki/FAQ'
  version '1.1'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'SKIP'

  no_upstream_update

  def self.build
    File.write 'clear-cache', <<~EOF
      #!/bin/bash
      cd $HOME
      SPACE_BEFORE=$(du -s | cut -f1)
      SPACE_BEFORE_HUMAN=$(du -hs | cut -f1)
      DIRS=".cache Cache Application_Cache Code_Cache GCache GPUCache Service_Worker"
      for D in $DIRS; do
        DIR=$(echo $D | sed 's,_, ,')
        [ -d "$DIR" ] && rm -rf "$DIR"
      done
      SPACE_AFTER=$(du -s | cut -f1)
      SPACE_AFTER_HUMAN=$(du -hs | cut -f1)
      SPACE_RECOVERED=$(($SPACE_BEFORE-$SPACE_AFTER))
      echo "Space used before: $SPACE_BEFORE_HUMAN"
      echo "Space used after: $SPACE_AFTER_HUMAN"
      echo "Space recovered: ${SPACE_RECOVERED}KB"
    EOF
  end

  def self.install
    FileUtils.install 'clear-cache', "#{CREW_DEST_PREFIX}/bin/clear-cache", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'clear-cache' to remove system cache files.\n".lightblue
  end
end
