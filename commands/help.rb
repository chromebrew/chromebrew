require_relative '../lib/const'

class Command
  def self.help(command, property)
    case command
    when 'build'
      puts <<~EOT
        Build package(s).
        Usage: crew build [-k|--keep] [-v|--verbose] <package1> [<package2> ...]
        Build package(s) from source and place the archive and checksum in the `CREW_LOCAL_BUILD_DIR/release/<arch>` directory.
        Build package(s) from source and place the archive and checksum in the current working directory.
        If `-k` or `--keep` is present, the `CREW_BREW_DIR` (#{CREW_BREW_DIR}) directory will remain.
        If `-v` or `--verbose` is present, extra information will be displayed.
      EOT
    when 'const'
      puts <<~EOT
        Display constant(s).
        Usage: crew const [<const1> <const2> ...]
        If no constants are provided, all constants will be displayed.
      EOT
    when 'deps'
      puts <<~EOT
        Display dependencies of package(s).
        Usage: crew deps [-t|--tree] [-b|--include-build-deps] [--exclude-buildessential] <package1> [<package2> ...]

        If `-t` or `--tree` specified, dependencies will be printed in a tree-structure format
        If `-b` or `--include-build-deps` specified, build dependencies will be included in output
        It `--exclude-buildessential` specified, `buildessential` and its dependencies will not be inserted automatically
      EOT
    when 'download'
      puts <<~EOT
        Download package(s).
        Usage: crew download [-s|--source] [-v|--verbose] <package1> [<package2> ...]
        Download package(s) to `CREW_BREW_DIR` (#{CREW_BREW_DIR}), but don't install.
        If `-s` or `--source` is present, the source will be downloaded instead of the binary.
        If `-v` or `--verbose` is present, extra information will be displayed.
      EOT
    when 'files'
      puts <<~EOT
        Display installed files of package(s).
        Usage: crew files <package1> [<package2> ...]
        The package(s) must be currently installed.
      EOT
    when 'install'
      puts <<~EOT
        Install package(s).
        Usage: crew install [-k|--keep] [-s|--source] [-S|--recursive-build] [-v|--verbose] <package1> [<package2> ...]
        The package(s) must have a valid name.  Use `crew search <pattern>` to search for packages to install.
        If `-k` or `--keep` is present, the `CREW_BREW_DIR` (#{CREW_BREW_DIR}) directory will remain.
        If `-s` or `--source` is present, the package(s) will be compiled instead of installed via binary.
        If `-S` or `--recursive-build` is present, the package(s), including all dependencies, will be compiled instead of installed via binary.
        If `-v` or `--verbose` is present, extra information will be displayed.
      EOT
    when 'license'
      puts <<~EOT
        Display the crew license.
        Usage: crew license
      EOT
    when 'list'
      puts <<~EOT
        List packages.
        Usage: crew list [-v|--verbose] available|installed|compatible|incompatible
      EOT
    when 'postinstall'
      puts <<~EOT
        Display postinstall messages of package(s).
        Usage: crew postinstall <package1> [<package2> ...]
        The package(s) must be currently installed.
      EOT
    when 'prop'
      help_prop(property)
    when 'reinstall'
      puts <<~EOT
        Remove and install package(s).
        Usage: crew reinstall [-k|--keep] [-s|--source] [-S|--recursive-build] [-v|--verbose] <package1> [<package2> ...]
        If `-k` or `--keep` is present, the `CREW_BREW_DIR` (#{CREW_BREW_DIR}) directory will remain.
        If `-s` or `--source` is present, the package(s) will be compiled instead of installed via binary.
        If `-S` or `--recursive-build` is present, the package(s), including all dependencies, will be compiled instead of installed via binary.
        If `-v` or `--verbose` is present, extra information will be displayed.
      EOT
    when 'remove'
      puts <<~EOT
        Remove package(s).
        Usage: crew remove [-v|--verbose] <package1> [<package2> ...]
        The package(s) must be currently installed.
        If `-v` or `--verbose` is present, extra information will be displayed.
      EOT
    when 'search'
      puts <<~EOT
        Look for package(s).
        Usage: crew search [-v|--verbose] [<pattern> ...]
        If <pattern> is omitted, all packages will be returned.
        If the package color is " + "green".lightgreen + ", it means the package is installed.
        If the package color is " + "red".lightred + ", it means the architecture is not supported.
        The <pattern> string can also contain regular expressions.
        If `-v` or `--verbose` is present, homepage, version and license will be displayed.
        Examples:
          crew search ^lib".lightblue + " will display all packages that start with `lib`.
          crew search audio".lightblue + " will display all packages with `audio` in the name.
          crew search | grep -i audio".lightblue + " will display all packages with `audio` in the name or description.
          crew search git -v".lightblue + " will display packages with `git` in the name along with homepage, version and license.
      EOT
    when 'sysinfo'
      puts <<~EOT
        Show system information.
        Usage: crew sysinfo
        If `-v` or `--verbose` is present, show system information with raw markdown.
      EOT
    when 'update'
      puts <<~EOT
        Update crew.
        Usage: crew update
        This only updates crew itself.  Use `crew upgrade` to update packages.
        Usage: crew update compatible
        This updates the crew package compatibility list.
      EOT
    when 'upgrade'
      puts <<~EOT
        Update package(s).
        Usage: crew upgrade [-v|--verbose] [-s|--source] <package1> [<package2> ...]
        If package(s) are omitted, all packages will be updated.  Otherwise, specific package(s) will be updated.
        Use `crew update` to update crew itself.
        If `-s` or `--source` is present, the package(s) will be compiled instead of upgraded via binary.
        If `-v` or `--verbose` is present, extra information will be displayed.
      EOT
    when 'upload'
      puts <<~EOT
        Upload binaries.
        Usage: crew upload [<package1> <package2> ...]
        This will update the binary_sha256 hashes in each package and upload binaries to GitLab.
        The GITLAB_TOKEN environment variable must be set to access the upstream repository.
        If no package(s) are provided, all binaries in `#{CREW_LOCAL_REPO_ROOT}/release/<arch>` will be uploaded.
        If `-v` or `--verbose` is present, additional debug information will be displayed.
      EOT
    when 'version'
      puts <<~EOT
        Display the crew version.
        Usage: crew version
      EOT
    when 'whatprovides'
      puts <<~EOT
        Determine which package(s) contains file(s).
        Usage: crew whatprovides <pattern> ...
        The <pattern> is a search string which can contain regular expressions.
      EOT
    else
      puts <<~EOT
        Usage: crew help <command>
        Available commands: build, const, deps, download, files, help, install, list, postinstall, prop, reinstall, remove, search, sysinfo, update, upgrade, upload, whatprovides, license, version
      EOT
    end
  end
end

def help_prop(property)
  if property
    case property
    when 'conflicts_ok'
      puts "The 'conflicts_ok' property bypasses checks for other package file conflicts."
    when 'git_clone_deep'
      puts "The 'git_clone_deep' property clones the repository without a depth value."
      puts "Applicable only when 'source_url' is a git repository."
    when 'git_fetchtags'
      puts "The 'git_fetchtags' property gets the repository tags."
      puts "Applicable only when 'source_url' is a git repository."
    when 'is_fake'
      puts "Use the 'is_fake' property for packages that simply depend on other packages."
    when 'is_musl'
      puts "Use the 'is_musl' property for musl specific packages."
    when 'is_static'
      puts "Use the 'is_static' property for packages which do not require shared dependencies."
    when 'no_compile_needed'
      puts "Use the 'no_compile_needed' property for packages that do not require pre-built binaries."
    when 'no_compress'
      puts "Use the 'no_compress' property for packages that do not need compressed files."
    when 'no_env_options'
      puts "Use the 'no_env_options' property for packages that do not require"
      puts 'environment options or to override the default options.'
    when 'no_fhs'
      puts "The 'no_fhs' property bypasses FHS3 compliance checks."
    when 'no_git_submodules'
      puts "Use the 'no_git_submodules' property for repositories without git submodules."
      puts "Applicable only when 'source_url' is a git repository."
    when 'no_links'
      puts "Use the 'no_links' property to bypass checks for duplicate links."
    when 'no_patchelf'
      puts "Use the 'no_patchelf' property to bypass patchelf execution."
    when 'no_shrink'
      puts "Use the 'no_shrink' property to bypass upx binary compression."
    when 'no_source_build'
      puts "Use the 'no_source_build' property to build even if source is unspecified or unavailable."
    when 'no_strip'
      puts "Use the 'no_strip' property to bypass strip execution."
    when 'no_lto'
      puts "Use the 'no_lto' property to bypass lto usage."
    when 'no_zstd'
      puts "Use the 'no_zstd' property for the alternate xz compression algorithm."
    when 'patchelf'
      puts "Use the 'patchelf' property for patchelf execution."
    when 'print_source_bashrc'
      puts "Prints 'source ~/.bashrc' message at end of install."
    when 'run_tests'
      puts "Use the 'run_tests' property to execute make check tests."
    else
      abort "Invalid property '#{property}'".lightred
    end
  else
    puts <<~EOT
      Display all available package boolean properties.
      Usage: crew prop
    EOT
  end
end
