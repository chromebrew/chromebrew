require 'package'

class Clear_cache < Package
  description 'Script to remove system cache files'
  homepage 'https://github.com/skycocker/chromebrew/wiki/FAQ'
  version '1.0'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  def self.build
    system "cat << 'EOF' > clear-cache
#!/bin/bash
cd \$HOME
SPACE_BEFORE=\$(du -s | cut -f1)
SPACE_BEFORE_HUMAN=\$(du -hs | cut -f1)
DIRS=\".cache Cache Application_Cache Code_Cache GCache GPUCache Service_Worker\"
for D in \$DIRS; do
  DIR=\$(echo \$D | sed \'s,_, ,\')
  [ -d \"\$DIR\" ] && rm -rf \"\$DIR\"
done
SPACE_AFTER=\$(du -s | cut -f1)
SPACE_AFTER_HUMAN=\$(du -hs | cut -f1)
SPACE_RECOVERED=\$((\$SPACE_BEFORE-\$SPACE_AFTER))
echo \"Space used before: \$SPACE_BEFORE_HUMAN\"
echo \"Space used after: \$SPACE_AFTER_HUMAN\"
echo \"Space recovered: \${SPACE_RECOVERED}KB\"
EOF"
  end

  def self.install
    system "install -Dm755 clear-cache #{CREW_DEST_PREFIX}/bin/clear-cache"
  end

  def self.postinstall
    puts
    puts "Type 'clear-cache' to remove system cache files.".lightblue
    puts
  end
end
