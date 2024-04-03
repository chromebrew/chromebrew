require_relative '../lib/package'

class Command
  def self.prop(property)
    case property
    when 'arch_flags_override'
      puts "Use the 'arch_flags_override' property to override architecture specific flags."
    when 'conflicts_ok'
      puts "The 'conflicts_ok' property bypasses checks for other package file conflicts."
    when 'git_clone_deep'
      puts "The 'git_clone_deep' property clones the repository without a depth value."
      puts "Applicable only when 'source_url' is a git repository."
    when 'git_fetchtags'
      puts "The 'git_fetchtags' property gets the repository tags."
      puts "Applicable only when 'source_url' is a git repository."
    when 'gnome'
      puts "Use the 'gnome' property to include options for gnome specific packages."
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
    when 'no_lto'
      puts "Use the 'no_lto' property to bypass lto usage."
    when 'no_patchelf'
      puts "Use the 'no_patchelf' property to bypass patchelf execution."
    when 'no_shrink'
      puts "Use the 'no_shrink' property to bypass upx binary compression."
    when 'no_source_build'
      puts "Use the 'no_source_build' property to build even if source is unspecified or unavailable."
    when 'no_strip'
      puts "Use the 'no_strip' property to bypass strip execution."
    when 'no_upstream_update'
      puts "Use the 'no_upstream_update' property for packages that cannot be updated from an upstream repository."
    when 'no_zstd'
      puts "Use the 'no_zstd' property for the alternate xz compression algorithm."
    when 'patchelf'
      puts "Use the 'patchelf' property for patchelf execution."
    when 'print_source_bashrc'
      puts "Prints 'source ~/.bashrc' message at end of install."
    when 'run_tests'
      puts "Use the 'run_tests' property to execute make check tests."
    else
      puts <<~EOT
        Explain the purpose of various package boolean properties.
        Usage: crew prop <property>
        Available properties: #{Package.print_boolean_properties}
      EOT
    end
  end
end

