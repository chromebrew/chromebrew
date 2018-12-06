require 'package'

class Ld_default < Package
  description 'Select the default ld executable and check for libraries in #{CREW_LIB_PREFIX} first'
  homepage 'https://github.com/skycocker/chromebrew/wiki/FAQ'
  version '1.1'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  depends_on 'llvm'

  def self.build
    system "cat << 'EOF' > ld_default
#!/bin/bash

  set -e

  mktmp=\$(mktemp -d)

  cd #{CREW_PREFIX}/bin

  type=\$(file ld | cut -d' ' -f2 | tr -d '\\n')

  if [ \"\${type}\" == \"ELF\" ]; then
    current=\$(find . -inum \$(ls -i ld | cut -d' ' -f1) | fgrep 'ld.')
  elif [ \"${type}\" == \"symbolic\" ]; then	
    current=\$(basename \$(readlink ld))
  else
    current=\$(basename \$(tail -1 ld | cut -d' ' -f1))
  fi

  echo
  echo \"  Current default linker: \${current}\"
  echo
  echo '  Enter the new default linker:'
  echo
  echo '  b = ld.bfd'
  echo '  g = ld.gold'
  echo '  l = ld.lld'
  echo '  0 = Cancel'
  echo

  while true; do
    read default
    case \${default} in
      b)
        new='ld.bfd'
        break;;
      g)
        new='ld.gold'
        break;;
      l)
        new='ld.lld'
        break;;
      0)
        exit;;
      *)
        echo 'Please select from one of the options or enter 0 to cancel.'
        echo
    esac
  done

  echo '#!/bin/bash' > \${mktmp}/ld
  echo \"\${new}\"' --library-path #{CREW_LIB_PREFIX} -rpath #{CREW_LIB_PREFIX} \"\$@\"' >> \${mktmp}/ld

  install -Dm755 \${mktmp}/ld #{CREW_PREFIX}/bin/ld

  rm -rf \${mktmp}
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
