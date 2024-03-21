require 'minitest/autorun'
require_relative '../../commands/help'

class HelpCommandTest < Minitest::Test
  def test_no_arguments
    expected_output = <<~EOT
      Usage: crew help <command>
      Available commands: build, check, const, deps, download, files, help, install, license, list, postinstall, prop, reinstall, remove, search, sysinfo, test, update, upgrade, upload, version, whatprovides
    EOT
    assert_output expected_output, nil do
      Command.help(nil)
    end
  end

  def test_prop_command
    expected_output = <<~EOT
      Explain the purpose of various package boolean properties.
      Usage: crew prop <property>
      Available properties: arch_flags_override, conflicts_ok, git_clone_deep, git_fetchtags, gnome, is_fake, is_musl, is_static, no_compile_needed, no_compress, no_env_options, no_fhs, no_git_submodules, no_links, no_lto, no_patchelf, no_shrink, no_source_build, no_strip, no_upstream_update, no_zstd, patchelf, print_source_bashrc, run_tests
    EOT
    assert_output expected_output, nil do
      Command.help('prop')
    end
  end

  def test_const_command
    expected_output = <<~EOT
      Display constant(s).
      Usage: crew const [<const1> <const2> ...]
      If no constants are provided, all constants will be displayed.
    EOT
    assert_output expected_output, nil do
      Command.help('const')
    end
  end
end
