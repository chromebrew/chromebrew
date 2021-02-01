require 'package'

class Rtws < Package
  description 'Script to remove trailing whitespace'
  homepage 'https://github.com/skycocker/chromebrew/wiki/FAQ'
  version '1.0'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  def self.build
    system "cat << 'EOF' > rtws
#!/bin/bash
[ -z \$1 ] && echo 'Usage: rtws [file]' && exit 1
[ ! -f \$1 ] && echo 'Usage: rtws [file]' && exit 1
sed -i 's/[ \\t]*\$//' \$1
EOF"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'rtws', "#{CREW_DEST_PREFIX}/bin/rtws", mode: 0755
  end

  def self.postinstall
    puts
    puts "Execute 'rtws [file]' to remove trailing whitespace.".lightblue
    puts
  end
end
