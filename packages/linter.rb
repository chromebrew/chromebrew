require 'package'

class Linter < Package
  description 'Comprehensive linter and code analysis for various file types.'
  homepage 'https://github.com/chromebrew/chromebrew'
  version '1.4'
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'

  no_compile_needed
  no_upstream_update

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
            mdl -c "$HOME/.mdlrc" "$file"
            ;;
          rb)
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
    mdlrc = <<~EOF
      style "#{Dir.home}/.mdl_style.rb"
    EOF
    File.write('.mdlrc', mdlrc)
    mdl_style = <<~EOF
      all
      # Ignore 80 character line length limit.
      exclude_rule 'MD013'
      # Ignore horizontal rule style.
      exclude_rule 'MD035'
      # Ignore emphasis used instead of a header.
      exclude_rule 'MD036'
      # Ignore first line in file should be a top level header.
      exclude_rule 'MD041'
      # Ignore code block style.
      exclude_rule 'MD046'
    EOF
    File.write('.mdl_style.rb', mdl_style)
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_HOME.to_s
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'linter', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.install ['.mdlrc', '.mdl_style.rb'], CREW_DEST_HOME.to_s, mode: 0o644
  end
end
