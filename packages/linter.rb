require 'package'

class Linter < Package
  description 'Comprehensive linter and code analysis for various file types.'
  homepage 'https://github.com/chromebrew/chromebrew'
  version '1.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'

  no_compile_needed

  depends_on 'py3_codespell'
  depends_on 'ruby_mdl'
  depends_on 'ruby_rubocop'
  depends_on 'ruby_yaml_lint'
  depends_on 'shellcheck'

  def self.build
    linter = <<~EOF
      #!/bin/bash
      export PATH=#{CREW_PREFIX}/bin:$PATH
      if test "$1"; then
        files="$*"
      else
        files="$(git ls-files -om | xargs)"
      fi
      for file in $files; do
        ext="${file##*.}"
        if ! [[ "$ext" =~ ^(md|rb|sh|yml|yaml)$ ]]; then
          type="$(file -b "$file" | cut -d' ' -f1)"
          case $type in
            Bourne-Again)
              ext="sh"
              ;;
            HTML)
              ext="md"
              ;;
            Ruby)
              ext="rb"
              ;;
          esac
        fi
        case $ext in
          md)
            mdl "$file"
            ;;
          rb)
            ruby=true
            rubocop "$file"
            ;;
          sh)
            shellcheck "$file"
            ;;
          yml|yaml)
            yaml-lint "$file"
            ;;
          *)
            echo "Unable to check syntax of $file."
            ;;
        esac
        codespell "$file"
      done
    EOF
    File.write('linter', linter)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'linter', "#{CREW_DEST_PREFIX}/bin/linter", mode: 0o755
  end
end
