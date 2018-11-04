require 'package'

class Ld_default < Package
  description 'Select the default ld executable and check for libraries in #{CREW_LIB_PREFIX} first'
  homepage 'https://github.com/skycocker/chromebrew'
  version '1.0'
  source_url 'https://raw.githubusercontent.com/skycocker/chromebrew/93aa4dc4d9198e28d84dcf9d59b3ab6b6a94d92c/README.md'
  source_sha256 '3ec9c6f7ba6a138d07dfb4a372d562cd3ad558b58b6bd447c2dbb52e16b697a5'

  depends_on 'llvm'

  def self.build
system "cat << 'EOF' > ld_default
#!/bin/bash
cd #{CREW_PREFIX}/bin
type=\$(file ld | cut -d' ' -f2 | tr -d '\\n')
if [ \"\$type\" == \"ELF\" ]; then
  current=\$(find . -inum $(ls -i ld 2> /dev/null | cut -d' ' -f1) 2> /dev/null | fgrep 'ld.' 2> /dev/null | cut -d/ -f2 2> /dev/null)
else
  slashes=\$(tr -dc '/' <<<'#{CREW_PREFIX}/bin/ld/' | wc -c)
  current=\$(tail -1 ld | cut -d'/' -f\${slashes} 2> /dev/null | cut -d' ' -f1 2> /dev/null)
fi
echo
echo \"Current default: \$current\"
echo
echo 'Enter the ld default:'
echo 'b = ld.bfd'
echo 'g = ld.gold'
echo 'l = ld.lld'
echo '0 = Cancel'
while true; do
  read default
  case $default in
    b)
      current='ld.bfd'
      break;;
    g)
      current='ld.gold'
      break;;
    l)
      current='ld.lld'
      break;;
    0)
      exit;;
    *)
      echo 'Please select from one of the options or enter 0 to cancel.'
  esac
done
echo '#!/bin/bash' > /tmp/ld
echo '#{CREW_PREFIX}/bin/'$current' --library-path #{CREW_LIB_PREFIX} -rpath #{CREW_LIB_PREFIX} \"\$@\"' >> /tmp/ld
install -Dm755 /tmp/ld #{CREW_PREFIX}/bin/ld
rm -f /tmp/ld
EOF"
  end

  def self.install
    system "install -Dm755 ld_default #{CREW_DEST_PREFIX}/bin/ld_default"
  end

  def self.postinstall
    puts
    puts "To change the default linker, execute `ld_default`.".lightblue
    puts
  end
end
